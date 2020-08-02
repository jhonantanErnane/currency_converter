import 'package:mobx/mobx.dart';

part 'drawer_tile_controller.g.dart';

class DrawerTileController = _DrawerTileBase with _$DrawerTileController;

abstract class _DrawerTileBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
