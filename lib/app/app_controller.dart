import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import './shared/enums/enum_theme.dart';
import 'shared/repositories/local_repository/local_repository_shared_preferences.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  final _sharedPrefences = Modular.get<LocalRepositorySharedPreferences>();

  static final Map<int, Color> _colorCodes = {
    50: Color.fromRGBO(255, 209, 133, .1),
    100: Color.fromRGBO(255, 209, 133, .2),
    200: Color.fromRGBO(255, 209, 133, .3),
    300: Color.fromRGBO(255, 209, 133, .4),
    400: Color.fromRGBO(255, 209, 133, .5),
    500: Color.fromRGBO(255, 209, 133, .6),
    600: Color.fromRGBO(255, 209, 133, .7),
    700: Color.fromRGBO(255, 209, 133, .8),
    800: Color.fromRGBO(255, 209, 133, .9),
    900: Color.fromRGBO(255, 209, 133, 1),
  };

  static final _lightTheme = ThemeData(
    primarySwatch: MaterialColor(0xFFFFD185, _colorCodes),
  );

  static final _darkTheme = ThemeData.dark()
      .copyWith(primaryColor: MaterialColor(0xFFFFD185, _colorCodes));

  @observable
  ThemeData currentTheme = _lightTheme;

  EnumTheme activeTheme = EnumTheme.LIGHTTHEME;

  _AppControllerBase() {
    _init();
  }

  @action
  Future<void> changeTheme() async {
    if (currentTheme == _lightTheme) {
      activeTheme = EnumTheme.DARKTHEME;
      currentTheme = _darkTheme;
    } else {
      activeTheme = EnumTheme.LIGHTTHEME;
      currentTheme = _lightTheme;
    }
    await _sharedPrefences.saveThemeChoiced(activeTheme);
  }

  Future<void> _init() async {
    final themeSaved = await _sharedPrefences.getThemeChoiced();
    if (themeSaved != EnumTheme.LIGHTTHEME.toString()) {
      changeTheme();
    }
  }
}
