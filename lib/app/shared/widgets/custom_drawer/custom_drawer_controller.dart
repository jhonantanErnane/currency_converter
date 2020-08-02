import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../models/drawer_tile_model.dart';

part 'custom_drawer_controller.g.dart';

class CustomDrawerController = _CustomDrawerBase with _$CustomDrawerController;

abstract class _CustomDrawerBase with Store {
  @observable
  List<DrawerTileModel> drawerTileList = [];

  _CustomDrawerBase() {
    _init();
  }

  _init() {
    drawerTileList = [
      DrawerTileModel(
          displayText: 'Home',
          icon: Icons.home,
          onTap: () {
            Modular.to.pop();
            Modular.to.pushReplacementNamed('/home');
          }),
      DrawerTileModel(
          displayText: 'Histórico',
          icon: Icons.history,
          onTap: () {
            Modular.to.pop();
            Modular.to.pushReplacementNamed('/report');
          }),
      DrawerTileModel(
          displayText: 'Logoff',
          icon: Icons.exit_to_app,
          onTap: () {
            Modular.to.pop();
            Modular.to.pushReplacementNamed('/');
          }),
    ];
  }
}
