import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../custom_dio.dart';
import 'methods_interface.dart';
import 'headers_interface.dart';
import 'parameters_interface.dart';
import 'path_interface.dart';
import 'query_parameters.dart';
import 'run_interface.dart';

class CustomDioBuilder
    implements
        MethodsInterface,
        PathInterface,
        HeadersInterface,
        ParametersInterface,
        QueryParametersInterface,
        RunInterface {
  final _customDio = Modular.get<CustomDio>();
  String _methodValue;
  String _pathValue;
  Map<String, dynamic> _headers;
  dynamic _dataValue;
  Map<String, dynamic> _queryParameters;

  CustomDioBuilder._();

  static MethodsInterface get instance => CustomDioBuilder._();

  @override
  PathInterface get() {
    _methodValue = 'get';
    return this;
  }

  @override
  PathInterface patch() {
    _methodValue = 'patch';
    return this;
  }

  @override
  PathInterface post() {
    _methodValue = 'post';
    return this;
  }

  @override
  PathInterface put() {
    _methodValue = 'put';
    return this;
  }

  @override
  HeadersInterface path(String path) {
    _pathValue = path;
    return this;
  }

  @override
  HeadersInterface addHeader(String name, value) {
    _headers ??= {};
    _headers.addAll({name: value});
    return this;
  }

  @override
  ParametersInterface params() {
    return this;
  }

  @override
  RunInterface data(data) {
    _dataValue = data;
    return this;
  }

  @override
  QueryParametersInterface queryParameters() {
    return this;
  }

  @override
  QueryParametersInterface addQueryParam(String name, value) {
    _queryParameters ??= {};
    _queryParameters.addAll({name: value});
    return this;
  }

  @override
  Future<Response> run() {
    return _customDio.client.request(_pathValue,
        options: Options(method: _methodValue, headers: _headers),
        queryParameters: _queryParameters,
        data: _dataValue);
  }
}
