import 'query_parameters.dart';
import 'run_interface.dart';

abstract class ParametersInterface {
  QueryParametersInterface queryParameters();
  RunInterface data(dynamic data);
}