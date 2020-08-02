import 'package:dio/dio.dart';

const BASEURL = 'https://api.exchangeratesapi.io/';

class CustomDio {
  static CustomDio _instance;

  CustomDio._();

  static CustomDio get instance {
    _instance ??= CustomDio._();
    return _instance;
  }

  Dio get client => _init();

  _init() {
    BaseOptions options = new BaseOptions(
      baseUrl: BASEURL,
      // connectTimeout: 5000,
      // receiveTimeout: 3000,
    );
    final dio = Dio(options);
    return dio;
  }
}
