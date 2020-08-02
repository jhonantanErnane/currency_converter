import 'package:currency_converter/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appController = Modular.get<AppController>();
    return Observer(builder: (context) {
      return MaterialApp(
        navigatorKey: Modular.navigatorKey,
        title: 'Currency Converter',
        theme: _appController.currentTheme,
        initialRoute: '/',
        onGenerateRoute: Modular.generateRoute,
      );
    });
  }
}
