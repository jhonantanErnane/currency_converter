import 'package:dio/dio.dart';

abstract class RunInterface {
  Future<Response> run();
}