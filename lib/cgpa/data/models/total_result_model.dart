import 'package:riverpod_practice/cgpa/data/models/semester_sgpa_model.dart';

class TotalResultModel {
  final double cgpa;
  final double percentage;
  final double totalCredits;
  final List<SemesterSgpaModel> semesterSgpaData;

  TotalResultModel({
    required this.cgpa,
    required this.percentage,
    required this.totalCredits,
    required this.semesterSgpaData,
  });
}
