import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../flavors.dart';

@module
abstract class NetworkModule {
  @Named('base_url')
  @singleton
  String get baseUrl => F.baseUrl;

  @singleton
  Dio dio(
    @Named('base_url') String baseUrl,
  ) {
    var option = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );

    var headers = <String, dynamic>{
      "Content-Type" : "application/json",
    };

    var dio = Dio(option);
    dio.options.headers = headers;

    return dio;
  }
}
