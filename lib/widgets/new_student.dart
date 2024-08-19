import 'package:flutter/material.dart';

class NewStudent extends StatefulWidget {
  const NewStudent({super.key});
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
            'Please make sure a valid Student Name, Age, Section and Tuition Fee was entered'),
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

  void _submitStudentButton() {
    final _ageAmount = double.tryParse(_ageController.text);
    final _tuitionAmount = double.tryParse(_tuitionFeeController.text);
    final enteredIsInvalid = _ageAmount == null ||
        _ageAmount <= 0 ||
        _tuitionAmount == null ||
        _tuitionAmount <= 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  onPressed: () {},
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
    );
  }
}
