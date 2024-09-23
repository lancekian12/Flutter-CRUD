import 'package:flutter/material.dart';
import 'package:crud_activity/model/student_model.dart';
import 'package:crud_activity/services/fetch_data.dart';

class NewStudentScreen extends StatefulWidget {
  const NewStudentScreen({super.key});

  @override
  State<NewStudentScreen> createState() {
    return _NewStudentScreenState();
  }
}

class _NewStudentScreenState extends State<NewStudentScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  String _selectedYear = 'First Year';
  bool _isEnrolled = false;

  void _submitStudentButton() async {
    final enteredIsInvalid = _firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty ||
        _courseController.text.trim().isEmpty ||
        _selectedYear.isEmpty;

    if (enteredIsInvalid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all the required fields.'),
        ),
      );
      return;
    }

    final newStudent = StudentModel(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      course: _courseController.text.trim(),
      year: _selectedYear,
      enrolled: _isEnrolled,
    );

    try {
      await createStudent(newStudent);
      Navigator.of(context).pop(true);
    } catch (e) {
      print('Error adding student: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error adding student.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Student'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
              DropdownButtonFormField<String>(
                value: _selectedYear,
                decoration: const InputDecoration(labelText: 'Year'),
                items:
                    ['First Year', 'Second Year', 'Third Year', 'Fourth Year']
                        .map((year) => DropdownMenuItem<String>(
                              value: year,
                              child: Text(year),
                            ))
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedYear = value!;
                  });
                },
              ),
              Row(
                children: [
                  const Text('Enrolled:'),
                  Switch(
                    value: _isEnrolled,
                    onChanged: (value) {
                      setState(() {
                        _isEnrolled = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitStudentButton,
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
