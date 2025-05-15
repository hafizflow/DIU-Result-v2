class SgpaResult {
  final String courseTitle;
  final String gradeLetter;
  final double pointEquivalent;
  final String semesterName;
  final int semesterYear;
  final double totalCredit;
  final double cgpa;

  SgpaResult({
    required this.courseTitle,
    required this.gradeLetter,
    required this.pointEquivalent,
    required this.semesterName,
    required this.semesterYear,
    required this.totalCredit,
    required this.cgpa,
  });

  factory SgpaResult.fromJson(Map<String, dynamic> json) {
    return SgpaResult(
      courseTitle: json['courseTitle'] ?? '',
      gradeLetter: json['gradeLetter'] ?? '',
      pointEquivalent: (json['pointEquivalent'] ?? 0).toDouble(),
      semesterName: json['semesterName'] ?? '',
      semesterYear: json['semesterYear'] ?? 0,
      cgpa: (json['cgpa'] ?? 0).toDouble(),
      totalCredit: (json['totalCredit'] ?? 0).toDouble(),
    );
  }
}
