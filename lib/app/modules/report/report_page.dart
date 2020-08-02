import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/widgets/converted_list/converted_list_widget.dart';
import '../../shared/widgets/custom_loading/custom_loading_widget.dart';
import '../../shared/delegates/search_converted_delegate.dart';
import '../../shared/widgets/custom_drawer/custom_drawer_widget.dart';

import 'report_controller.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends ModularState<ReportPage, ReportController> {
  final _scaffold = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      drawer: const CustomDrawerWidget(),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => _scaffold.currentState.openDrawer()),
        title: const Text(
          'Histórico',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () async {
              await showSearch(
                  context: context,
                  delegate: SearchConverted(
                    onDelete: controller.delConverted,
                  ));
            },
          ),
        ],
      ),
      body: Observer(builder: (_) {
        return CustomLoadingWidget(
          isLoading: controller.isLoading,
          child: ConvertedListWidget(
            converteds: controller.converteds,
            isLoading: controller.isLoading,
            onDelete: controller.delConverted,
          ),
        );
      }),
    );
  }
}
