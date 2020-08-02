import 'package:flutter/material.dart';

class DrawerTileModel {
  final IconData icon;
  final String displayText;
  final Function onTap;

  DrawerTileModel(
      {@required this.icon, @required this.displayText, @required this.onTap});
}
