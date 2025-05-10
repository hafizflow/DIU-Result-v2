import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/cgpa/data/models/semester_model.dart';
import 'package:riverpod_practice/sgpa/logic/sgpa_result_provider.dart';

final semesterLists = FutureProvider<List<Semester>?>((ref) async {
  final repo = ref.watch(resultRepositoryProvider);
  try {
    return await repo.fetchSemesters();
  } catch (e) {
    return null;
  }
});
