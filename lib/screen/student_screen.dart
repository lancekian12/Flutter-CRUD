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
              studentsFuture = fetchStudents();
            });
          },
          onStudentUpdated: () {
            setState(() {
              studentsFuture = fetchStudents();
            });
          },
        ),
      ),
    );
  }

  void _navigateToNewStudent() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _firstNameController = TextEditingController();
        final _lastNameController = TextEditingController();
        final _courseController = TextEditingController();
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
            // widget.onAddStudent(newStudent);
            Navigator.of(context).pop();
            setState(() {
              studentsFuture = fetchStudents();
            });
          } catch (e) {
            print('Error adding student: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error adding student.'),
              ),
            );
          }
        }

        return AlertDialog(
          title: const Text('Add New Student'),
          content: SingleChildScrollView(
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
                    _selectedYear = value!;
                  },
                ),
                Row(
                  children: [
                    const Text('Enrolled:'),
                    Switch(
                      value: _isEnrolled,
                      onChanged: (value) {
                        _isEnrolled = value;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog without saving
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _submitStudentButton,
              child: const Text('Add'),
            ),
          ],
        );
      },
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
