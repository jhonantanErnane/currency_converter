import 'package:currency_converter/app/shared/widgets/convertedListTile/convertedListTile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/converted_model.dart';

import 'converted_list_controller.dart';

class ConvertedListWidget extends StatelessWidget {
  final Function(int id) onDelete;
  final bool isLoading;

  final List<ConvertedModel> converteds;

  ConvertedListWidget(
      {@required this.converteds,
      @required this.onDelete,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<ConvertedListController>();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    if (isLoading) {
      return Container();
    }

    if (converteds == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (converteds.length == 0) {
      return listEmpty(context);
    }

    return ListView.builder(
      itemCount: converteds.length,
      itemBuilder: (BuildContext context, int index) {
        ConvertedModel converted = converteds[index];
        return GestureDetector(
          onTapDown: controller.onTapDown,
          onLongPress: () {
            showMenu(
              context: context,
              items: [
                PopupMenuItem(
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        "Excluir",
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Modular.to.pop();
                        _showDialog(converted, context);
                      },
                    ),
                  ),
                ),
              ],
              position: controller.getRelativeRect(overlay),
            );
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: ConvertedListTileWidget(
                converted: converted,
              )),
        );
      },
    );
  }

  Column listEmpty(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Icon(
            Icons.list,
            size: 120,
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Text(
            'Não existe nenhum histórico ainda',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }

  void _showDialog(ConvertedModel converted, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Deseja realmente excluir o registro?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                Modular.to.pop();
              },
            ),
            FlatButton(
              child: Text("Sim"),
              onPressed: () {
                Modular.to.pop();
                onDelete(converted.id);
              },
            ),
          ],
        );
      },
    );
  }
}
