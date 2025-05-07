import 'package:dio/dio.dart';
import 'package:riverpod_practice/core%20/constants/api_constants.dart';

// class DioClient {
//   static final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: ApiConstants.baseUrl,
//       connectTimeout: const Duration(seconds: 300),
//       receiveTimeout: const Duration(seconds: 300),
//     ),
//   );

//   static Dio get instance => _dio;
// }

class DioClient {
  static final Dio _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    )
    ..interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          if (error.type == DioExceptionType.connectionError ||
              error.type == DioExceptionType.unknown) {
            error = error.copyWith(
              error: 'No internet connection or server unavailable',
            );
          }
          return handler.next(error);
        },
      ),
    );

  static Dio get instance => _dio;
}
