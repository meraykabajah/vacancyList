import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class Network {
  Network._();

  static late Dio dio;

  static init() async {
    dio = Dio();
  }

  static Future<Response> get({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    final response = await dio.get(url, queryParameters: query).timeout(
      const Duration(minutes: 2),
      onTimeout: () {
        throw DioException(
          error: "Connection timeout",
          requestOptions: RequestOptions(path: url, queryParameters: query),
          type: DioExceptionType.connectionTimeout,
        );
      },
    );
    return response;
  }

  static Future<Response> post({
    required String url,
    Map<String, dynamic>? query,
    var data,
  }) async {
    var response =
        await dio.post(url, data: data, queryParameters: query).timeout(
      const Duration(minutes: 2),
      onTimeout: () {
        throw DioException(
          error: "Connection timeout",
          requestOptions: RequestOptions(path: url, queryParameters: query),
          type: DioExceptionType.connectionTimeout,
        );
      },
    );
    return response;
  }
}

getCubitExceptionMessage(error) {
  if (error is DioException) {
    return handleDioException(error: error);
  } else {
    return tr('somethingWentWrong');
  }
}

String handleDioException({required DioException error}) {
  String message;
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      message = 'Connection timeout';
      break;

    case DioExceptionType.sendTimeout:
      message = 'Send Timeout';
      break;

    case DioExceptionType.receiveTimeout:
      message = 'Receive Timeout';
      break;

    case DioExceptionType.badResponse:
      log('error.message: ${error.message}');

      try {
        String errorDescription =
            error.response?.data?['errors']?[0]?['description'] ?? '';
        log('error.data: $errorDescription');

        //message = errorDescription.ifEmpty('Bad response');
        message = 'Bad response';
      } catch (e) {
        message = 'Bad response';
      }
      break;

    case DioExceptionType.cancel:
      message = 'Request is cancelled';
      break;

    case DioExceptionType.badCertificate:
      message = 'Invalid certificate';
      break;

    case DioExceptionType.connectionError:
      message = 'Connection error';
      break;

    case DioExceptionType.unknown:
      error.message?.contains('SocketException') ?? true
          ? message = 'Unknown Error'
          : message = error.message ?? 'Unknown error';
      break;
  }

  return message;
}
