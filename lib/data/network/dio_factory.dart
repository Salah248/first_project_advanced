// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:first_project_advanced/app/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    Duration timeOut = const Duration(
        milliseconds: Constants.apiTimeOut); // تحويل الوقت إلى Duration

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constants.token,
      DEFAULT_LANGUAGE: 'en'
    };
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout: timeOut,
      sendTimeout: timeOut,
    );

    if (!kReleaseMode) {
      // its depug mode so print app logs
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }

    return dio;
  }
}
