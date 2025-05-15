import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/cgpa/data/repositories/result_repository.dart';
import 'package:riverpod_practice/sgpa/model/sgpa_student_model.dart';

final isSearchedProvider = StateProvider<bool>((ref) => false);
final sIdProvider = StateProvider<String>((ref) => '');

final sgpaStudentInfoProvider = FutureProvider<SgpaStudentInfoModel?>((
  ref,
) async {
  final studentId = ref.watch(sIdProvider).trim();
  if (studentId.isEmpty) return null;

  final studentInfo = await ResultRepository().fetchSgpaStudentInfo(studentId);
  if (studentInfo.studentName.isEmpty) {
    return null;
  }
  return studentInfo;
});
