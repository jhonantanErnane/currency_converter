import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/widgets/converted_list/converted_list_controller.dart';
import '../../modules/report/report_controller.dart';
import '../../shared/repositories/local_repository/local_repository_Sqlite.dart';
import '../../shared/repositories/repository_interface.dart';
import '../../modules/report/report_page.dart';

class ReportModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ReportController()),
        Bind((i) => ConvertedListController()),
        Bind<ILocalRepository>((i) => LocalStorageSqlite()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => ReportPage()),
      ];

  static Inject get to => Inject<ReportModule>.of();
}
