import 'dart:async';

import 'package:currency_converter/app/shared/models/converted_model.dart';

import '../repository_interface.dart';
import 'package:sqflite/sqflite.dart';

const String DBNAME = 'flutter_currency.db';
const int DBVERSION = 1;
const String TABLECONVERTED = 'converted';

const List<String> dbCreate = [
  '''CREATE TABLE converted(
      id INTEGER PRIMARY KEY,
      baseCurrency TEXT,
      value REAL,
      toConverterCurrency TEXT,
      valueConverted REAL,
      search TEXT)'''
];

class LocalStorageSqlite extends ILocalRepository {
  Completer<Database> _dbInstance = Completer<Database>();

  LocalStorageSqlite() {
    _init();
  }

  _init() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + DBNAME;
    // await deleteDatabase(path);
    Database db = await openDatabase(path,
        version: DBVERSION,
        onOpen: (Database db) {}, onCreate: (Database db, int version) async {
      dbCreate.forEach((String sql) async {
        try {
          await db.execute(sql);
        } catch (e) {
          print(e);
        }
      });
    });
    _dbInstance.complete(db);
  }

  @override
  Future<List<ConvertedModel>> getAll() async {
    try {
      final dbInstance = await _dbInstance.future;
      final convertedMap = await dbInstance.query(TABLECONVERTED);
      return convertedMap
          .map<ConvertedModel>((e) => ConvertedModel.fromJson(e))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<ConvertedModel>> getAllFilterSuggestions(String search) async {
    final dbInstance = await _dbInstance.future;
    try {
      final suggestionsMap = await dbInstance.query(TABLECONVERTED,
          where: 'search like ?',
          whereArgs: ['%$search%']);
      return suggestionsMap.map((e) => ConvertedModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<void> postConvertedModel(ConvertedModel converted) async {
    final dbInstance = await _dbInstance.future;
    try {
      await dbInstance.insert(TABLECONVERTED, converted.toJson());
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteConvert(int id) async {
    final dbInstance = await _dbInstance.future;
    try {
      await dbInstance.delete(TABLECONVERTED, where: 'id == ?', whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }
}
