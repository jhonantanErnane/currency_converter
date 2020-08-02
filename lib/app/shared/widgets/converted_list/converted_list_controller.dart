import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'converted_list_controller.g.dart';

class ConvertedListController = _ConvertedListControllerBase
    with _$ConvertedListController;

abstract class _ConvertedListControllerBase with Store {
  Offset tapPosition;

  void onTapDown(TapDownDetails details) {
    tapPosition = details.globalPosition;
  }

  RelativeRect getRelativeRect(RenderBox overlay) => RelativeRect.fromRect(
        tapPosition & Size(40, 40), // smaller rect, the touch area
        Offset.zero & overlay.size, // Bigger rect, the entire screen
      );
}
