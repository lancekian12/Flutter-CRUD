import 'package:flutter/material.dart';
import 'package:crud_activity/model/student_model.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    required this.student,
    required this.onTap,
    super.key,
  });

  final StudentModel student;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${student.firstName} ${student.lastName}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Course: ${student.course}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Year: ${student.year}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8.0),
              Text(
                'Enrolled: ${student.enrolled ? "Yes" : "No"}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: student.enrolled ? Colors.green : Colors.red,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
