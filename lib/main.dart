import 'package:flutter/material.dart';
import 'package:crud_activity/student.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Student(),
    ),
  );
}
