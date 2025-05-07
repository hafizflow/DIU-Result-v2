class Semester {
  final String semesterId;

  Semester({required this.semesterId});

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(semesterId: json['semesterId']);
  }
}
