import 'package:flutter/material.dart';
import '../../models/drawer_tile_model.dart';

class DrawerTileWidget extends StatelessWidget {
  final DrawerTileModel model;
  final bool islast;
  const DrawerTileWidget({Key key, @required this.model, @required this.islast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color:
                          islast ? Colors.transparent : Colors.grey.shade400))),
          child: InkWell(
            splashColor: Colors.blueAccent,
            onTap: model.onTap,
            child: Container(
              height: screenSize.height * 0.10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(model.icon),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(model.displayText),
                      )
                    ],
                  ),
                  Icon(Icons.arrow_right)
                ],
              ),
            ),
          ),
        ));
  }
}
