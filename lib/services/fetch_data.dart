import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crud_activity/model/student_model.dart';

// Create new student data
Future<void> createStudent(StudentModel student) async {
  final url = Uri.parse('http://10.0.2.2:3000/api/v1/student');
  print('Creating student at: $url'); // Debugging line

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'studentName': student.studentName,
        'age': student.age,
        'section': student.section,
        'tuitionFee': student.tuitionFee,
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

// Fetch student data
Future<List<Map<String, dynamic>>> fetchData() async {
  final url = Uri.parse('http://10.0.2.2:3000/api/v1/student');
  print('Fetching data from: $url');

  try {
    final response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      // Access the student data
      final studentList = responseData['data']['student'] as List<dynamic>;

      return studentList.map((student) {
        return {
          '_id': student['_id'], // Ensure '_id' is included
          'studentName': student['studentName'] ?? 'Unknown',
          'age': student['age'] ?? 0,
          'section': student['section'] ?? 'Unknown',
          'tuitionFee': student['tuitionFee'] ?? 0,
        };
      }).toList();
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Error: $e');
  }
}

// Update student data
// Update student data
Future<void> updateStudent(String studentId, StudentModel updatedData) async {
  final url = Uri.parse('http://10.0.2.2:3000/api/v1/student/$studentId');
  print('Updating student at: $url');

  try {
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'studentName': updatedData.studentName,
        'age': updatedData.age,
        'section': updatedData.section,
        'tuitionFee': updatedData.tuitionFee,
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

// Delete student data
Future<void> deleteData(String studentId) async {
  if (studentId.isEmpty) {
    throw Exception('Student ID cannot be empty');
  }

  final url = Uri.parse('http://10.0.2.2:3000/api/v1/student/$studentId');
  print('Deleting data from: $url'); // Debugging line

  try {
    final response = await http.delete(url);

    print('Delete response status: ${response.statusCode}'); // Debugging line

    if (response.statusCode != 204) {
      throw Exception('Failed to delete data');
    }
  } catch (e) {
    print('Error: $e'); // Detailed logging
    throw Exception('Error: $e');
  }
}
