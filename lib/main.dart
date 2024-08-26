import 'package:crud_activity/screen/student_screen.dart';
import 'package:crud_activity/screen/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:crud_activity/student.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);
void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App',
      theme: theme,
      home: StudentScreen(),
    );
  }
}
