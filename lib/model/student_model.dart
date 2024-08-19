class StudentModel {
  StudentModel({
    required this.studentName,
    required this.age,
    required this.section,
    required this.tuitionFee,
  });

  final String studentName;
  final int age;
  final String section;
  final int tuitionFee;

  // // Optionally, add methods to convert from/to JSON
  // factory StudentModel.fromJson(Map<String, dynamic> json) {
  //   return StudentModel(
  //     studentName: json['studentName'],
  //     age: json['age'],
  //     section: json['section'],
  //     tuitionFee: json['tuitionFee'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'studentName': studentName,
  //     'age': age,
  //     'section': section,
  //     'tuitionFee': tuitionFee,
  //   };
  // }
}
