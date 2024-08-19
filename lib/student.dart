import 'package:flutter/material.dart';
import '../services/fetch_data.dart';
import 'package:crud_activity/widgets/new_student.dart';
import 'package:crud_activity/widgets/update_student.dart';
import 'package:crud_activity/model/student_model.dart';

class Student extends StatefulWidget {
  Student({super.key});
  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {
  late Future<List<Map<String, dynamic>>> studentFuture;

  @override
  void initState() {
    super.initState();
    studentFuture = fetchData();
  }

  Future<void> _updateStudent(Map<String, dynamic> updatedData) async {
    try {
      final studentId = updatedData['_id'];
      final updatedStudent = StudentModel(
        studentName: updatedData['studentName'],
        age: updatedData['age'],
        section: updatedData['section'],
        tuitionFee: updatedData['tuitionFee'],
      );

      await updateStudent(studentId, updatedStudent);
      setState(() {
        studentFuture = fetchData();
      });
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  Future<void> _deleteStudent(String studentId) async {
    try {
      await deleteData(studentId);
      setState(() {
        studentFuture = fetchData();
      });
    } catch (e) {
      print('Error deleting data: $e');
    }
  }

  void _openAddStudentOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewStudent(
        onAddStudent: (newStudent) {
          setState(() {
            studentFuture = fetchData();
          });
        },
      ),
    );
  }

  void _openUpdateStudentOverlay(Map<String, dynamic> studentData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => UpdateStudent(
        studentData: studentData,
        onUpdateStudent: (updatedStudent) {
          setState(() {
            studentFuture = fetchData();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Student'),
        actions: [
          IconButton(
            onPressed: _openAddStudentOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: studentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            final studentList = snapshot.data!;
            return ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (context, index) {
                final student = studentList[index];
                return ListTile(
                  title: Text(student['studentName']),
                  subtitle: Text(
                      'Age: ${student['age']}, Section: ${student['section']}, Fee: ${student['tuitionFee']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _openUpdateStudentOverlay(student);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          final studentId = student['_id'];
                          if (studentId != null) {
                            _deleteStudent(studentId);
                          } else {
                            print('Student ID is null');
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
