import 'package:dio/dio.dart';

abstract class QueryParametersInterface {
  QueryParametersInterface addQueryParam(String name, dynamic value);
  Future<Response> run();
}