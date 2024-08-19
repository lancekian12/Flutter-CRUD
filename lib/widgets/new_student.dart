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
  final _studentNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _sectionController = TextEditingController();
  final _tuitionFeeController = TextEditingController();

  @override
  void dispose() {
    _studentNameController.dispose();
    _ageController.dispose();
    _sectionController.dispose();
    _tuitionFeeController.dispose();

    super.dispose();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content: const Text(
            'Please make sure a valid Student Name, Age, Section, and Tuition Fee were entered'),
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
    final _ageAmount = int.tryParse(_ageController.text);
    final _tuitionAmount = int.tryParse(_tuitionFeeController.text);
    final enteredIsInvalid = _ageAmount == null ||
        _ageAmount <= 0 ||
        _tuitionAmount == null ||
        _tuitionAmount <= 0;

    if (_studentNameController.text.trim().isEmpty ||
        _sectionController.text.trim().isEmpty ||
        enteredIsInvalid) {
      _showDialog();
      return;
    }

    final newStudent = StudentModel(
      studentName: _studentNameController.text.trim(),
      age: _ageAmount!,
      section: _sectionController.text.trim(),
      tuitionFee: _tuitionAmount!,
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
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _studentNameController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Student Name:"),
                ),
              ),
              TextField(
                controller: _ageController,
                maxLength: 50,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Student Age:"),
                ),
              ),
              TextField(
                controller: _sectionController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Student Section:"),
                ),
              ),
              TextField(
                controller: _tuitionFeeController,
                maxLength: 50,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Student Tuition Fee:"),
                ),
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
