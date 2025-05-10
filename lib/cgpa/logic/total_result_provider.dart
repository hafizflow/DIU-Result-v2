import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/cgpa/data/models/result_model.dart';
import 'package:riverpod_practice/cgpa/data/models/semester_sgpa_model.dart';
import 'package:riverpod_practice/cgpa/data/models/total_result_model.dart';
import 'package:riverpod_practice/cgpa/logic/result_provider.dart';

final totalResultProvider = Provider<TotalResultModel>((ref) {
  final allResults = ref.watch(resultListProvider).asData?.value ?? [];

  double totalPoints = 0.0;
  double totalCredits = 0.0;
  List<SemesterSgpaModel> semesterSgpaData = [];
  List<Result> resultList = [];

  for (var semester in allResults) {
    semesterSgpaData.add(
      SemesterSgpaModel(
        "${semester.first.semesterName} ${semester.first.semesterYear.toString()}",
        semester.first.cgpa,
      ),
    );
    resultList.addAll(semester);
  }

  Set<String> processedCourses = {};

  for (var result in resultList) {
    totalPoints += (result.pointEquivalent) * (result.totalCredit);

    if (!processedCourses.contains(result.courseTitle)) {
      totalCredits += result.totalCredit;
      processedCourses.add(result.courseTitle);
    }
  }

  if (totalCredits == 0) {
    return TotalResultModel(
      cgpa: 0.0,
      percentage: 0.0,
      totalCredits: 0.0,
      semesterSgpaData: [],
    );
  }

  final cgpa = totalPoints / totalCredits;
  final percentage = (cgpa / 4) * 100;

  return TotalResultModel(
    cgpa: cgpa,
    percentage: percentage,
    totalCredits: totalCredits,
    semesterSgpaData: semesterSgpaData,
  );
});
