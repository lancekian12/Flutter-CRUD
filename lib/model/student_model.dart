class StudentModel {
  StudentModel({
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.year,
    required this.enrolled,
    this.id = "",
  });
  final String id;
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? 'Unknown',
      lastName: json['lastName'] ?? 'Unknown',
      course: json['course'] ?? 'Unknown',
      year: json['year'] ?? 'Unknown',
      enrolled: json['enrolled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'course': course,
      'year': year,
      'enrolled': enrolled,
    };
  }
}
