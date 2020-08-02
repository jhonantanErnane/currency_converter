import 'package:currency_converter/app/app_controller.dart';
import 'package:currency_converter/app/shared/enums/enum_theme.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final _appController = Modular.get<AppController>();

  changeTheme(EnumTheme themeChoice) {
    if (_appController.activeTheme != themeChoice) {
      _appController.changeTheme();
    }
  }
}
