import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import './shared/repositories/local_repository/local_repository_shared_preferences.dart';
import './app_widget.dart';
import './modules/login/login_module.dart';
import './app_controller.dart';
import './modules/home/home_module.dart';
import './modules/report/report_module.dart';
import 'shared/custom_dio/custom_dio.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind<CustomDio>((i) => CustomDio.instance),
        Bind<LocalRepositorySharedPreferences>(
            (i) => LocalRepositorySharedPreferences())
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, module: LoginModule()),
        Router('/home', module: HomeModule()),
        Router('/report', module: ReportModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
