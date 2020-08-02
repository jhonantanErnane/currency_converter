import 'package:currency_converter/app/shared/models/converted_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../shared/repositories/repository_interface.dart';
part 'report_controller.g.dart';

class ReportController = _ReportControllerBase with _$ReportController;

abstract class _ReportControllerBase with Store {
  final _storage = Modular.get<ILocalRepository>();

  @observable
  bool isLoading = true;

  _ReportControllerBase() {
    _init();
  }

  ObservableList<ConvertedModel> converteds = ObservableList<ConvertedModel>();

  Future<void> _init() async {
    try {
      isLoading = true;
      converteds = (await _storage.getAll()).asObservable();
      print(converteds);
      isLoading = false;
    } catch (e) {
      print(e);
      isLoading = false;
    }
  }

  Future<void> delConverted(int id) async {
    try {
      await _storage.deleteConvert(id);
      await _init();
    } catch (e) {
      print(e);
    }
  }
}
