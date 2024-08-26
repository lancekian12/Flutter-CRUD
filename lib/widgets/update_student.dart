// import 'package:flutter/material.dart';
// import '../services/fetch_data.dart';
// import 'package:crud_activity/model/student_model.dart';

// class UpdateStudent extends StatefulWidget {
//   final Map<String, dynamic> studentData;
//   final Function(StudentModel) onUpdateStudent;

//   UpdateStudent(
//       {required this.studentData, required this.onUpdateStudent, Key? key})
//       : super(key: key);

//   @override
//   _UpdateStudentState createState() => _UpdateStudentState();
// }

// class _UpdateStudentState extends State<UpdateStudent> {
//   final _studentNameController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _sectionController = TextEditingController();
//   final _tuitionFeeController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the controllers with the data
//     _studentNameController.text = widget.studentData['studentName'] ?? '';
//     _ageController.text = (widget.studentData['age'] ?? 0).toString();
//     _sectionController.text = widget.studentData['section'] ?? '';
//     _tuitionFeeController.text =
//         (widget.studentData['tuitionFee'] ?? 0).toString();
//   }

//   @override
//   void dispose() {
//     _studentNameController.dispose();
//     _ageController.dispose();
//     _sectionController.dispose();
//     _tuitionFeeController.dispose();
//     super.dispose();
//   }

//   void _showDialog() {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('Invalid input'),
//         content: const Text(
//             'Please make sure a valid Student Name, Age, Section, and Tuition Fee were entered. Make sure Student Name and Section is 8 characters'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(ctx);
//             },
//             child: const Text('Okay'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _submitUpdateButton() async {
//     final _ageAmount = int.tryParse(_ageController.text);
//     final _tuitionAmount = int.tryParse(_tuitionFeeController.text);
//     final enteredIsInvalid = _ageAmount == null ||
//         _ageAmount <= 0 ||
//         _tuitionAmount == null ||
//         _tuitionAmount <= 0;

//     if (_studentNameController.text.trim().isEmpty ||
//         _studentNameController.text.length <= 8 ||
//         _sectionController.text.trim().isEmpty ||
//         _sectionController.text.length <= 8 ||
//         enteredIsInvalid) {
//       _showDialog();
//       return;
//     }

//     final updatedStudent = StudentModel(
//       studentName: _studentNameController.text.trim(),
//       age: _ageAmount!,
//       section: _sectionController.text.trim(),
//       tuitionFee: _tuitionAmount!,
//     );

//     try {
//       await updateStudent(widget.studentData['_id'], updatedStudent);
//       widget.onUpdateStudent(updatedStudent);
//       Navigator.of(context).pop();
//     } catch (e) {
//       print('Error updating student: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
//       height: MediaQuery.of(context).size.height,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: _studentNameController,
//                 maxLength: 50,
//                 decoration: const InputDecoration(
//                   label: Text("Student Name:"),
//                 ),
//               ),
//               TextField(
//                 controller: _ageController,
//                 maxLength: 50,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   label: Text("Student Age:"),
//                 ),
//               ),
//               TextField(
//                 controller: _sectionController,
//                 maxLength: 50,
//                 decoration: const InputDecoration(
//                   label: Text("Student Section:"),
//                 ),
//               ),
//               TextField(
//                 controller: _tuitionFeeController,
//                 maxLength: 50,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   label: Text("Student Tuition Fee:"),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   ElevatedButton(
//                     onPressed: _submitUpdateButton,
//                     child: const Text(
//                       "Update Student",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
