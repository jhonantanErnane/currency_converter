import 'package:flutter/material.dart';
import 'custom_drawer_controller.dart';
import '../../widgets/drawer_tile/drawer_tile_widget.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget();
  @override
  Widget build(BuildContext context) {
    final controller = CustomDrawerController();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xffffd185), Color(0xffcca76a)],
            )),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                                'images/flutter_transparent_logo.png'))),
                  ),
                  Text(
                    'Conversor de Moedas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.drawerTileList.length,
            itemBuilder: (_, index) {
              return DrawerTileWidget(
                model: controller.drawerTileList[index],
                islast: controller.drawerTileList.length - 1 == index,
              );
            },
          )
        ],
      ),
    );
  }
}
