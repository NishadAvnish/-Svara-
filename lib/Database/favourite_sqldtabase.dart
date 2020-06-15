import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:svara/Model/audiobook_model.dart';

class Databasehelper {
  static Database _database;
  String transTable = 'Transactions_Table';
  String colTitle = 'title';
  String colImageUrl = 'imageUrl';
  String colAudioUrl = 'audioUrl';

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    String path = join(directory.path, 'favourites.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);

    return db;
  }

  _onCreate(Database db, int version) async {
    //PRIMARY KEY AUTOINCREMENT
    db.execute(
        'CREATE TABLE $transTable($colTitle TEXT PRIMARY KEY , $colImageUrl TEXT, $colAudioUrl TEXT)');
  }

  Future<List<AudioBookModel>> getFavourite() async {
    var dbClient = await database;
    final List<Map<String, dynamic>> maps = await dbClient.query(transTable);
    return List.generate(maps.length, (i) {
      return AudioBookModel(
        title: maps[i]['$colTitle'],
        imageUrl: maps[i]['$colImageUrl'],
        audioUrl: maps[i]['$colAudioUrl'],
      );
    });
  }

  Future<bool> isPresent(AudioBookModel transaction) async {
    var dbClient = await database;
    final List<Map<String, dynamic>> maps = await dbClient.rawQuery(
        "SELECT * FROM $transTable WHERE $colTitle = '${transaction.title}'");
    if (maps.length > 0) {
      return true;
    } else
      return false;
  }

  Future<void> addtoDatabase(AudioBookModel transaction) async {
    var dbClient = await database;

    final bool _isPresent = await isPresent(transaction);
    if (!_isPresent) {
      await dbClient.insert(
        transTable,
        transaction.tomap(),
      );
    }
  }

  Future<void> delete(String title) async {
    var dbClient = await database;
    return await dbClient.delete(
      transTable,
      where: '$colTitle = ?',
      whereArgs: [title],
    );
  }

  Future close() async {
    var dbClient = await database;
    dbClient.close();
  }
}
