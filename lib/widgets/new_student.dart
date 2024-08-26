import 'package:flutter/material.dart';
import 'package:crud_activity/model/student_model.dart';
import 'package:crud_activity/services/fetch_data.dart';

class NewStudent extends StatefulWidget {
  const NewStudent({required this.onAddStudent, super.key});
  final Function(StudentModel) onAddStudent;

  @override
  State<NewStudent> createState() {
    return _NewStudentState();
  }
}

class _NewStudentState extends State<NewStudent> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _courseController = TextEditingController();
  String _selectedYear = 'First Year';
  bool _isEnrolled = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content: const Text(
            'Please make sure a valid First Name, Last Name, Course, and Year were entered.'),
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

  void _submitStudentButton() async {
    final enteredIsInvalid = _firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty ||
        _courseController.text.trim().isEmpty ||
        _selectedYear.isEmpty;

    if (enteredIsInvalid) {
      _showDialog();
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
      widget.onAddStudent(newStudent);
      Navigator.of(context).pop();
    } catch (e) {
      print('Error adding student: $e');
      _showDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final yearOptions = [
      'First Year',
      'Second Year',
      'Third Year',
      'Fourth Year',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Student'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _firstNameController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("First Name:"),
                ),
              ),
              TextField(
                controller: _lastNameController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Last Name:"),
                ),
              ),
              TextField(
                controller: _courseController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Course:"),
                ),
              ),
              DropdownButtonFormField<String>(
                value: _selectedYear,
                decoration: const InputDecoration(
                  labelText: 'Year',
                ),
                items: yearOptions
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _submitStudentButton,
                    child: const Text(
                      "Add Student",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
