import 'package:currency_converter/app/shared/models/currency_model.dart';
import 'package:currency_converter/app/shared/widgets/custom_loading/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/widgets/custom_drawer/custom_drawer_widget.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final _scaffold = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
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
          title: Text(
            'Conversão de Moeda',
            style: TextStyle(
                fontSize: screenSize.width * 0.05, color: Colors.white),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Modular.to.pushReplacementNamed('/report'),
                child: Text(
                  'Histórico',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
        body: Observer(builder: (_) {
          return CustomLoadingWidget(
            isLoading: controller.isLoading,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 10),
                child: Form(
                    child: Column(
                  children: <Widget>[
                    Observer(builder: (_) {
                      return _customDropDown(
                          labelDropDown: 'TIPO MOEDA',
                          rates: controller.currency?.rates,
                          selectedCurrency: controller.baseCurrency,
                          setSelectedCurrency: controller.setBaseCurrency);
                    }),
                    TextField(
                      controller: controller.txValue,
                      decoration: InputDecoration(hintText: 'valor R\$'),
                      inputFormatters: [controller.ctf],
                      keyboardType: TextInputType.number,
                    ),
                    _customSizedBox(screenSize, 0.10),
                    Observer(builder: (_) {
                      return _customDropDown(
                          labelDropDown: 'MOEDA DESEJADA',
                          rates: controller.currency?.rates,
                          selectedCurrency: controller.toConvertCurrency,
                          setSelectedCurrency: controller.setToConvertCurrency);
                    }),
                    _customSizedBox(screenSize, 0.05),
                    TextField(
                      controller: controller.txValueConverted,
                      enabled: false,
                      decoration: InputDecoration(hintText: 'Novo Valor'),
                      inputFormatters: [controller.ctf],
                      keyboardType: TextInputType.number,
                    ),
                    _customSizedBox(screenSize, 0.10),
                    RaisedButton(
                      onPressed: () async {
                        controller.convertCurrency();
                      },
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'CONVERTER',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )),
              ),
            ),
          );
        }));
  }

  Widget _customSizedBox(Size screenSize, double value) {
    return SizedBox(
      height: screenSize.height * value,
    );
  }

  Widget _customDropDown(
      {@required String labelDropDown,
      @required Rates rates,
      @required Map selectedCurrency,
      @required Function setSelectedCurrency}) {
    return new Observer(builder: (_) {
      if (controller.currency == null ||
          rates == null ||
          rates.convertTocurrency == null ||
          rates.convertTocurrency.isEmpty) {
        return Container();
      } else {
        return DropdownButton<Map<String, double>>(
          isExpanded: true,
          value: selectedCurrency,
          hint: Text(labelDropDown),
          onChanged: (newValue) {
            print(newValue.values.first);
            setSelectedCurrency(newValue);
          },
          items: rates.convertTocurrency
              .map<DropdownMenuItem<Map<String, double>>>((Map value) {
            return DropdownMenuItem<Map<String, double>>(
              value: value,
              child: Text(value.keys.first),
            );
          }).toList(),
        );
      }
    });
  }
}
