import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/repositories/repository_interface.dart';
import '../../shared/repositories/local_repository/local_repository_Sqlite.dart';
import '../../modules/home/home_page.dart';
import '../../modules/home/home_controller.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
        Bind<ILocalRepository>((i) => LocalStorageSqlite()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
