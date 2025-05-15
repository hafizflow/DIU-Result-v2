import 'package:dio/dio.dart';
import 'package:riverpod_practice/core%20/constants/api_constants.dart';
import 'package:riverpod_practice/core%20/services/dio_client.dart';
import 'package:riverpod_practice/cgpa/data/models/student_info_model.dart';
import 'package:riverpod_practice/sgpa/model/sgpa_model.dart';
import 'package:riverpod_practice/sgpa/model/sgpa_semester.dart';
import 'package:riverpod_practice/sgpa/model/sgpa_student_model.dart';
import '../models/semester_model.dart';
import '../models/result_model.dart';

class ResultRepository {
  final Dio _dio = DioClient.instance;

  Future<StudentInfoModel> fetchStudentInfo(String studentId) async {
    try {
      final response = await _dio.get(
        ApiConstants.studentInfoEndpoint,
        queryParameters: {'studentId': studentId},
      );
      return StudentInfoModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        throw 'No internet connection or server unavailable';
      }
      rethrow;
    }
  }

  Future<List<Semester>> fetchSemesters() async {
    try {
      final response = await _dio.get(ApiConstants.semesterListEndpoint);
      if (response.data == null || (response.data as List).isEmpty) {
        return [];
      }
      return (response.data as List)
          .map((json) => Semester.fromJson(json))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        throw 'No internet connection or server unavailable';
      }
      rethrow;
    }
  }

  Future<List<Result>> fetchResults(String studentId, String semesterId) async {
    try {
      final response = await _dio.get(
        ApiConstants.resultEndpoint,
        queryParameters: {
          'grecaptcha': '',
          'studentId': studentId,
          'semesterId': semesterId,
        },
      );

      if (response.data == null || response.data == '') {
        return [];
      }
      return (response.data as List)
          .map((json) => Result.fromJson(json))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        throw 'No internet connection or server unavailable';
      }
      rethrow;
    }
  }

  Future<List<SgpaResult>> fetchSgpaResults(
    String studentId,
    String semesterId,
  ) async {
    try {
      final response = await _dio.get(
        ApiConstants.resultEndpoint,
        queryParameters: {
          'grecaptcha': '',
          'studentId': studentId,
          'semesterId': semesterId,
        },
      );

      if (response.data == null || response.data == '') {
        return [];
      }
      return (response.data as List)
          .map((json) => SgpaResult.fromJson(json))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        throw 'No internet connection or server unavailable';
      }
      rethrow;
    }
  }

  Future<SgpaStudentInfoModel> fetchSgpaStudentInfo(String studentId) async {
    try {
      final response = await _dio.get(
        ApiConstants.studentInfoEndpoint,
        queryParameters: {'studentId': studentId},
      );
      return SgpaStudentInfoModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        throw 'No internet connection or server unavailable';
      }
      rethrow;
    }
  }

  Future<List<SgpaSemester>> fetchSgpaSemesters() async {
    try {
      final response = await _dio.get(ApiConstants.semesterListEndpoint);
      if (response.data == null || (response.data as List).isEmpty) {
        return [];
      }
      return (response.data as List)
          .map((json) => SgpaSemester.fromJson(json))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        throw 'No internet connection or server unavailable';
      }
      rethrow;
    }
  }
}
