import 'parameters_interface.dart';
import 'query_parameters.dart';

abstract class HeadersInterface {
  HeadersInterface addHeader(String name, dynamic value);
  QueryParametersInterface addQueryParam(String name, value);
  ParametersInterface params();
}
