import 'package:flutter/material.dart';
import 'package:crud_activity/model/student_model.dart';
import 'package:crud_activity/services/fetch_data.dart';
import 'package:crud_activity/widgets/card_widget.dart';
import 'package:crud_activity/widgets/new_student.dart';
import 'package:crud_activity/screen/student_details_screen.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() {
    return _StudentStateScreen();
  }
}

class _StudentStateScreen extends State<StudentScreen> {
  late Future<List<StudentModel>> studentsFuture;

  @override
  void initState() {
    super.initState();
    studentsFuture = fetchStudents();
  }

  void _navigateToStudentDetails(StudentModel student) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StudentDetailsScreen(
          student: student,
          onStudentDeleted: () {
            setState(() {
              studentsFuture = fetchStudents(); // Refresh student list
            });
          },
          onStudentUpdated: () {
            setState(() {
              studentsFuture = fetchStudents(); // Refresh student list
            });
          },
        ),
      ),
    );
  }

  void _navigateToNewStudent() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewStudent(
          onAddStudent: (student) {
            setState(() {
              studentsFuture = fetchStudents(); // Refresh student list
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'List of Students',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _navigateToNewStudent,
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<StudentModel>>(
        future: studentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final students = snapshot.data!;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return CardWidget(
                  student: students[index],
                  onTap: () => _navigateToStudentDetails(students[index]),
                );
              },
            );
          } else {
            return const Center(child: Text('No students found.'));
          }
        },
      ),
    );
  }
}
