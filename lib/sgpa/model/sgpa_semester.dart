class SgpaSemester {
  final String semesterId;
  final String semesterName;
  final int semesterYear;

  SgpaSemester({
    required this.semesterId,
    required this.semesterName,
    required this.semesterYear,
  });

  factory SgpaSemester.fromJson(Map<String, dynamic> json) {
    return SgpaSemester(
      semesterId: json['semesterId'],
      semesterName: json['semesterName'],
      semesterYear: json['semesterYear'],
    );
  }
}
