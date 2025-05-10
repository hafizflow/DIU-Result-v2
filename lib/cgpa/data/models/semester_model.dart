class Semester {
  final String semesterId;
  final String semesterName;
  final int semesterYear;

  Semester({
    required this.semesterId,
    required this.semesterName,
    required this.semesterYear,
  });

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      semesterId: json['semesterId'],
      semesterName: json['semesterName'],
      semesterYear: json['semesterYear'],
    );
  }
}
