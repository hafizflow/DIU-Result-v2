import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/cgpa/data/models/student_info_model.dart';
import 'package:riverpod_practice/cgpa/data/repositories/result_repository.dart';

final isSearchedProvider = StateProvider<bool>((ref) => false);
final sIdProvider = StateProvider<String>((ref) => '');

final sgpaStudentInfoProvider = FutureProvider<StudentInfoModel?>((ref) async {
  final studentId = ref.watch(sIdProvider).trim();
  if (studentId.isEmpty) return null;

  final studentInfo = await ResultRepository().fetchStudentInfo(studentId);
  if (studentInfo.studentName.isEmpty) {
    return null;
  }
  return studentInfo;
});
