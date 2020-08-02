import './path_interface.dart';

abstract class MethodsInterface {
  PathInterface post();
  PathInterface get();
  PathInterface put();
  PathInterface patch();
}
