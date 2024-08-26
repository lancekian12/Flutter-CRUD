import 'package:flutter/material.dart';
import 'package:crud_activity/model/student_model.dart';
import 'package:crud_activity/services/fetch_data.dart';

class UpdateStudentScreen extends StatefulWidget {
  const UpdateStudentScreen(
      {required this.student, required this.onUpdate, super.key});
  final StudentModel student;
  final Function(StudentModel) onUpdate;

  @override
  State<UpdateStudentScreen> createState() {
    return _UpdateStudentScreenState();
  }
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _courseController = TextEditingController();
  String _selectedYear = 'First Year';
  bool _isEnrolled = false;

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.student.firstName;
    _lastNameController.text = widget.student.lastName;
    _courseController.text = widget.student.course;
    _selectedYear = widget.student.year;
    _isEnrolled = widget.student.enrolled;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  void _submitUpdate() async {
    final updatedStudent = StudentModel(
      id: widget.student.id,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      course: _courseController.text,
      year: _selectedYear,
      enrolled: _isEnrolled,
    );

    try {
      await updateStudent(updatedStudent.id, updatedStudent);
      widget.onUpdate(updatedStudent);
      Navigator.of(context).pop();
    } catch (e) {
      _showDialog('Failed to update student');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Update Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _courseController,
              decoration: const InputDecoration(labelText: 'Course'),
            ),
            const SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _selectedYear,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedYear = value;
                  });
                }
              },
              items: <String>[
                'First Year',
                'Second Year',
                'Third Year',
                'Fourth Year',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: const Text('Select Year'),
            ),
            SwitchListTile(
              title: const Text('Enrolled'),
              value: _isEnrolled,
              onChanged: (value) {
                setState(() {
                  _isEnrolled = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitUpdate,
              child: const Text('Update Student'),
            ),
          ],
        ),
      ),
    );
  }
}
