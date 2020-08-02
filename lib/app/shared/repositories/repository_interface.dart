import '../../shared/models/converted_model.dart';

abstract class ILocalRepository {
  Future<List<ConvertedModel>> getAll();

  Future<void> postConvertedModel(ConvertedModel converted);

  Future<List<ConvertedModel>> getAllFilterSuggestions(String search);

  Future<void> deleteConvert(int id);

}
