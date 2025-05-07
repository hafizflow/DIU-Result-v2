class StudentInfoModel {
  final String studentName;
  final int batchNo;
  final String progShortName;

  StudentInfoModel({
    required this.studentName,
    required this.batchNo,
    required this.progShortName,
  });

  factory StudentInfoModel.fromJson(Map<String, dynamic> json) {
    return StudentInfoModel(
      studentName: json['studentName'] ?? '',
      batchNo: json['batchNo'] ?? 0,
      progShortName: json['progShortName'] ?? '',
    );
  }
}
