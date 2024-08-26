class StudentModel {
  StudentModel({
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.year,
    required this.enrolled,
  });

  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;
}
