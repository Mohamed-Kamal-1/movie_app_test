import 'package:dio/dio.dart';

import '../domain/api_result.dart';
import '../domain/exceptions/exceptions.dart';

Future<Result<T>> executeApi<T>(Future<T> Function() apiCall) async {
  try {
    final response = await apiCall();

    return Success(response);
  } on DioException catch (e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return Failure(NoInternetException(message: 'no internet connection'));
      default:
        {
          if (e.response != null) {
            return Failure(
              ServerError(message: e.response?.data['message'] ?? 'error more'),
            );
          }
        }
    }
  }
  return Failure(Exception('Something went Wrong'));
}
