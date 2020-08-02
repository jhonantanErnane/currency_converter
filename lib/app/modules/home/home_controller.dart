import 'package:currency_converter/app/shared/models/converted_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import '../../shared/repositories/repository_interface.dart';
import '../../shared/custom_dio/custom_dio_builder/custom_dio_builder.dart';
import '../../shared/models/currency_model.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final TextEditingController txValue = TextEditingController();
  final TextEditingController txValueConverted = TextEditingController();

  final _storage = Modular.get<ILocalRepository>();

  final CurrencyTextInputFormatter ctf =
      CurrencyTextInputFormatter(decimalDigits: 2, symbol: '');

  _HomeControllerBase() {
    getCurrency();
  }

  @observable
  CurrencyModel currency;

  @observable
  bool isLoading = true;

  @observable
  Map<String, double> baseCurrency;

  @observable
  Map<String, double> toConvertCurrency;

  @action
  void setBaseCurrency(Map value) {
    baseCurrency = value;
    getCurrency();
  }

  @action
  void setToConvertCurrency(Map value) {
    toConvertCurrency = value;
  }

  @action
  Future<void> convertCurrency() async {
    try {
      isLoading = true;
      if (toConvertCurrency == null ||
          txValue.value.text == null ||
          txValue.value.text.isEmpty) {
      } else {
        final valueToConvert =
            double.parse(txValue.value.text.replaceAll(',', ''));
        final valueConverted = (valueToConvert * toConvertCurrency.values.first)
            .toStringAsFixed(2);

        txValueConverted.text = valueConverted;

        ConvertedModel converted = ConvertedModel(
            baseCurrency: baseCurrency.keys.first,
            toConverterCurrency: toConvertCurrency.keys.first,
            value: valueToConvert,
            valueConverted: double.parse(valueConverted),
            search:
                '${baseCurrency.keys.first};${toConvertCurrency.keys.first};$valueToConvert;${double.parse(valueConverted)}');

        await _storage.postConvertedModel(converted);
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @action
  getCurrency() async {
    try {
      isLoading = true;
      toConvertCurrency = null;
      final resp = await CustomDioBuilder.instance
          .get()
          .path('/latest')
          .addQueryParam('base', baseCurrency?.keys?.first ?? 'BRL')
          .run();
      final tempInitialCurrency = CurrencyModel.fromJson(resp.data);
      baseCurrency = tempInitialCurrency.rates.convertTocurrency.firstWhere(
          (element) => baseCurrency == null
              ? element.keys.first == 'BRL'
              : element.keys.first == baseCurrency.keys.first);
      currency = tempInitialCurrency;
      isLoading = false;
    } catch (e) {
      isLoading = false;
      print(e);
    }
  }
}
