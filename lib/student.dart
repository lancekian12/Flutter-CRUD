// lib/screens/student_screen.dart

import 'package:flutter/material.dart';
import '../services/fetch_data.dart'; // Import the service file
import 'package:crud_activity/widgets/new_student.dart';

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
      await updateData(updatedData);
      setState(() {
        studentFuture = fetchData();
      });
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  Future<void> _deleteStudent(String studentId) async {
    try {
      await deleteData();
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
      builder: (ctx) => const NewStudent(),
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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
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
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _updateStudent({
                            'studentName': student['studentName'],
                            'age': student['age'],
                            'section': student['section'],
                            'tuitionFee': student['tuitionFee'],
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteStudent(student['studentName']);
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
