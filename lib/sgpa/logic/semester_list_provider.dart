import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/sgpa/logic/sgpa_result_provider.dart';
import 'package:riverpod_practice/sgpa/model/sgpa_semester.dart';

final semesterLists = FutureProvider<List<SgpaSemester>?>((ref) async {
  final repo = ref.watch(resultRepositoryProvider);
  try {
    return await repo.fetchSgpaSemesters();
  } catch (e) {
    return null;
  }
});
