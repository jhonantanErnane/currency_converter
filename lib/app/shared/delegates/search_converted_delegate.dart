import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/models/converted_model.dart';
import '../../shared/repositories/repository_interface.dart';
import '../../shared/widgets/convertedListTile/convertedListTile_widget.dart';
import '../../shared/widgets/converted_list/converted_list_widget.dart';

class SearchConverted extends SearchDelegate<ConvertedModel> {
  final _storage = Modular.get<ILocalRepository>();
  final Function(int id) onDelete;

  SearchConverted({@required this.onDelete});

  @override
  String get searchFieldLabel => 'Procure um registro...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        color: Colors.white,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    ThemeData theme = Theme.of(context);
    theme = theme.copyWith(
        textTheme: TextTheme(
          headline6: theme.textTheme.headline6.copyWith(color: Colors.white),
        ),
        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
            hintStyle: theme.textTheme.headline6.copyWith(
          color: Colors.white38,
        )));
    return theme;
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder<List<ConvertedModel>>(
        future: _storage.getAllFilterSuggestions(query),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ConvertedListWidget(
            converteds: snapshot.data,
            onDelete: onDelete,
          );
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder<List<ConvertedModel>>(
        future: suggestions(query),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<ConvertedModel> convertedList = snapshot.data;
          return ListView.builder(
            itemCount: convertedList.length,
            itemBuilder: (BuildContext context, int index) {
              return ConvertedListTileWidget(
                converted: convertedList[index],
              );
            },
          );
        },
      );
    }
  }

  Future<List<ConvertedModel>> suggestions(String search) async {
    return await _storage.getAllFilterSuggestions(search);
  }
}
