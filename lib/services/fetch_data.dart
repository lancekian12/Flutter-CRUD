import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crud_activity/model/student_model.dart';

//! Get Student

Future<List<StudentModel>> fetchStudents() async {
  final url = Uri.parse('https://node-js-crud-5tc5.vercel.app/api/v1/student');

  try {
    final response = await http.get(url);
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Decoded response data: $responseData');

      // Access the student data
      final studentList = responseData['data']['student'] as List<dynamic>;

      return studentList.map((student) {
        return StudentModel.fromJson(student);
      }).toList();
    } else {
      throw Exception('Failed to load students');
    }
  } catch (e) {
    print('Error fetching students: $e');
    throw Exception('Error fetching students: $e');
  }
}

//! Create new student data
Future<void> createStudent(StudentModel student) async {
  final url = Uri.parse('https://node-js-crud-5tc5.vercel.app/api/v1/student');
  print('Creating student at: $url');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstName': student.firstName,
        'lastName': student.lastName,
        'course': student.course,
        'year': student.year,
        'enrolled': student.enrolled,
      }),
    );

    print('Create response status: ${response.statusCode}');
    if (response.statusCode != 201) {
      throw Exception('Failed to create student');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Error: $e');
  }
}

//! Update student data
Future<void> updateStudent(String studentId, StudentModel updatedData) async {
  final url = Uri.parse(
      'https://node-js-crud-5tc5.vercel.app/api/v1/student/$studentId');
  print('Updating student at: $url');

  try {
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstName': updatedData.firstName,
        'lastName': updatedData.lastName,
        'course': updatedData.course,
        'year': updatedData.year,
        'enrolled': updatedData.enrolled,
      }),
    );

    print('Update response status: ${response.statusCode}');

    if (response.statusCode != 200) {
      throw Exception('Failed to update student');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Error: $e');
  }
}

//! Delete student data
Future<void> deleteStudent(String studentId) async {
  if (studentId.isEmpty) {
    throw Exception('Student ID cannot be empty');
  }

  final url = Uri.parse(
      'https://node-js-crud-5tc5.vercel.app/api/v1/student/$studentId');
  print('Deleting data from: $url');

  try {
    final response = await http.delete(url);

    print('Delete response status: ${response.statusCode}');

    if (response.statusCode != 204) {
      throw Exception('Failed to delete data');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Error: $e');
  }
}
