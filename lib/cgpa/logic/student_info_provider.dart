// providers/student_info_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/cgpa/data/models/student_info_model.dart';
import 'package:riverpod_practice/cgpa/data/repositories/result_repository.dart';
import 'package:riverpod_practice/cgpa/logic/result_provider.dart';

final hasSearchedProvider = StateProvider<bool>((ref) => false);

final studentInfoProvider = FutureProvider<StudentInfoModel?>((ref) async {
  final studentId = ref.watch(studentIdProvider).trim();
  if (studentId.isEmpty) return null;

  final studentInfo = await ResultRepository().fetchStudentInfo(studentId);
  if (studentInfo.studentName.isEmpty) {
    return null;
  }
  return studentInfo;
});
