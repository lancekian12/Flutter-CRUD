import 'package:flutter/material.dart';
import 'package:crud_activity/model/student_model.dart';
import 'package:crud_activity/services/fetch_data.dart';
import 'package:crud_activity/screen/update_student_screen.dart';

class StudentDetailsScreen extends StatefulWidget {
  const StudentDetailsScreen({
    required this.student,
    required this.onStudentDeleted,
    required this.onStudentUpdated,
    super.key,
  });

  final StudentModel student;
  final VoidCallback onStudentDeleted;
  final VoidCallback onStudentUpdated;

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

  Future<void> _confirmDeleteStudent() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this student?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      _deleteStudent();
    }
  }

  Future<void> _deleteStudent() async {
    try {
      await deleteStudent(_student.id);
      widget.onStudentDeleted();
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
            widget.onStudentUpdated();
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
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 24),
            ),
            Text(
              'Year: ${_student.year}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 24),
            ),
            Text(
              'Enrolled: ${_student.enrolled ? "Yes" : "No"}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _student.enrolled ? Colors.green : Colors.red,
                    fontSize: 24,
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
                  onPressed: _confirmDeleteStudent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
