class SgpaStudentInfoModel {
  final String studentName;
  final int batchNo;
  final String progShortName;

  SgpaStudentInfoModel({
    required this.studentName,
    required this.batchNo,
    required this.progShortName,
  });

  factory SgpaStudentInfoModel.fromJson(Map<String, dynamic> json) {
    return SgpaStudentInfoModel(
      studentName: json['studentName'] ?? '',
      batchNo: json['batchNo'] ?? 0,
      progShortName: json['progShortName'] ?? '',
    );
  }
}
