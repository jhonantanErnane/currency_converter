import 'package:flutter/material.dart';
import '../../../shared/models/converted_model.dart';

class ConvertedListTileWidget extends StatelessWidget {
  final ConvertedModel converted;

  const ConvertedListTileWidget({@required this.converted});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              'moeda e valor escolhidos: ${converted.baseCurrency} / ${converted.value}'),
          Text(
              'moeda e valor convertidos: ${converted.toConverterCurrency} / ${converted.valueConverted}')
        ],
      ),
    );
  }
}
