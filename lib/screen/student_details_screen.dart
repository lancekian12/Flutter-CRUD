import 'package:flutter/material.dart';
import 'package:crud_activity/model/student_model.dart';
import 'package:crud_activity/services/fetch_data.dart';
import 'package:crud_activity/screen/update_student_screen.dart';

// Add a callback parameter to the StudentDetailsScreen
class StudentDetailsScreen extends StatefulWidget {
  const StudentDetailsScreen(
      {required this.student,
      required this.onStudentDeleted, // Add this parameter
      super.key});

  final StudentModel student;
  final VoidCallback onStudentDeleted; // Add this callback

  @override
  State<StudentDetailsScreen> createState() {
    return _StudentDetailsScreenState();
  }
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  late StudentModel _student;

  @override
  void initState() {
    super.initState();
    _student = widget.student;
  }

  void _deleteStudent() async {
    try {
      await deleteStudent(_student.id);
      widget.onStudentDeleted(); // Notify the parent screen
      Navigator.of(context).pop();
    } catch (e) {
      print('Error deleting student: $e');
    }
  }

  void _updateStudent() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UpdateStudentScreen(
          student: _student,
          onUpdate: (updatedStudent) {
            setState(() {
              _student = updatedStudent;
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
          "Student Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${_student.firstName} ${_student.lastName}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Course: ${_student.course}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Year: ${_student.year}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Enrolled: ${_student.enrolled ? "Yes" : "No"}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _student.enrolled ? Colors.green : Colors.red,
                  ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _updateStudent,
                  child: const Text('Update'),
                ),
                ElevatedButton(
                  onPressed: _deleteStudent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red, // Set the background color to red
                  ),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
