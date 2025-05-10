import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/cgpa/data/repositories/result_repository.dart';
import 'package:riverpod_practice/cgpa/logic/student_info_provider.dart';
import '../data/models/result_model.dart';

final resultRepositoryProvider = Provider((ref) => ResultRepository());
final studentIdProvider = StateProvider<String>((ref) => '');

final resultListProvider = FutureProvider<List<List<Result>>>((ref) async {
  final studentInfo = await ref.watch(studentInfoProvider.future);
  if (studentInfo == null) return [];

  final studentId = ref.watch(studentIdProvider).trim();
  if (studentId.isEmpty || !studentId.contains('-')) return [];
  final repo = ref.watch(resultRepositoryProvider);
  final allSemesters = await repo.fetchSemesters();
  final int studentIDsFirst3String = int.tryParse(studentId.split('-')[0]) ?? 0;

  final validSemesters =
      allSemesters
          .where(
            (s) =>
                int.tryParse(s.semesterId) != null &&
                int.parse(s.semesterId) >= studentIDsFirst3String,
          )
          .map((s) => s.semesterId)
          .toList();

  List<List<Result>> allResults = [];

  for (String semesterId in validSemesters) {
    final results = await repo.fetchResults(studentId, semesterId);
    List<Result> currentSemesterResult = [];
    currentSemesterResult.addAll(results);

    if (currentSemesterResult.isNotEmpty && currentSemesterResult.length > 1) {
      allResults.add(currentSemesterResult);
    }
  }

  // print('All Semesters: ${allResults.length.toString()}');
  // print('Valid Semesters: $validSemesters');
  // print('Total courses: ${allSemesters.length}');

  return allResults;
});
