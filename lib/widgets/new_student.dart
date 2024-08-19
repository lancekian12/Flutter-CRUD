import 'package:flutter/material.dart';

class NewStudent extends StatefulWidget {
  const NewStudent({super.key});
  @override
  State<NewStudent> createState() {
    return _NewStudentState();
  }
}

class _NewStudentState extends State<NewStudent> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Student Name:"),
            ),
          ),
        ],
      ),
    );
  }
}
