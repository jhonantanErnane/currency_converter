class ConvertedModel {
  int id;
  String baseCurrency;
  double value;
  String toConverterCurrency;
  double valueConverted;
  String search;

  ConvertedModel(
      {this.id,
      this.baseCurrency,
      this.value,
      this.toConverterCurrency,
      this.valueConverted,
      this.search});

  ConvertedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    baseCurrency = json['baseCurrency'];
    value = json['value'];
    toConverterCurrency = json['toConverterCurrency'];
    valueConverted = json['valueConverted'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['baseCurrency'] = baseCurrency;
    data['value'] = value;
    data['toConverterCurrency'] = toConverterCurrency;
    data['valueConverted'] = valueConverted;
    data['search'] = search;
    return data;
  }
}
