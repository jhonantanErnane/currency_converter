class CurrencyModel {
  Rates rates;
  String base;
  String date;

  CurrencyModel({this.rates, this.base, this.date});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    rates = json['rates'] != null ? new Rates.fromJson(json['rates']) : null;
    base = json['base'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rates != null) {
      data['rates'] = this.rates.toJson();
    }
    data['base'] = this.base;
    data['date'] = this.date;
    return data;
  }
}

class Rates {
  final List<Map<String, double>> convertTocurrency = [];

  Rates.fromJson(Map<String, dynamic> json) {
    json.keys.forEach((key) {
      convertTocurrency.add({key: json[key]});
    });
  }

  Map<String, double> toJson() {
    final Map<String, double> data = new Map<String, double>();
    this.convertTocurrency.forEach((element) {
    });
    return data;
  }
}
