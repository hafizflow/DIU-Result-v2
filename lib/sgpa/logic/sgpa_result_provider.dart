import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/cgpa/data/repositories/result_repository.dart';
import 'package:riverpod_practice/sgpa/logic/sgpa_student_info_provider.dart';
import 'package:riverpod_practice/sgpa/model/sgpa_model.dart';

final resultRepositoryProvider = Provider((ref) => ResultRepository());
final semesterCodeProvider = StateProvider<String>((ref) => '');

final sgpaResultListProvider = FutureProvider<List<SgpaResult>>((ref) async {
  final studentInfo = await ref.watch(sgpaStudentInfoProvider.future);
  if (studentInfo == null) return [];

  final studentId = ref.watch(sIdProvider).trim();
  if (studentId.isEmpty || !studentId.contains('-')) return [];
  final repo = ref.watch(resultRepositoryProvider);
  final semesterCode = ref.watch(semesterCodeProvider).trim();

  List<SgpaResult> allResults = [];

  final results = await repo.fetchSgpaResults(studentId, semesterCode);
  allResults.addAll(results);

  return allResults;
});
