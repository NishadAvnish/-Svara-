import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:svara/Model/audiobook_model.dart';

class RecentlyDatabasehelper {
  static Database _database;
  String transTable = 'recentTable';
  String colTitle = 'title';
  String colImageUrl = 'imageUrl';
  String colAudioUrl = 'audioUrl';

  Future<Database> get recentDatabase async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    String path = join(directory.path, 'recently.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);

    return db;
  }

  _onCreate(Database db, int version) async {
    //PRIMARY KEY AUTOINCREMENT
    db.execute(
        'CREATE TABLE $transTable($colTitle TEXT PRIMARY KEY , $colImageUrl TEXT, $colAudioUrl TEXT)');
  }

  Future<List<AudioBookModel>> getRecently() async {
    var dbClient = await recentDatabase;
    final List<Map<String, dynamic>> maps = await dbClient.query(transTable);
    return List.generate(maps.length, (i) {
      return AudioBookModel(
        title: maps[i]['$colTitle'],
        imageUrl: maps[i]['$colImageUrl'],
        audioUrl: maps[i]['$colAudioUrl'],
      );
    });
  }

  Future<bool> _isPresent(String title) async {
    var dbClient = await recentDatabase;
    final List<Map<String, dynamic>> maps = await dbClient
        .rawQuery("SELECT * FROM $transTable WHERE $colTitle = '$title'");
    if (maps.length > 0) {
      await delete(title);
      return true;
    } else
      return false;
  }

  Future<bool> _isMorethanFour() async {
    var dbClient = await recentDatabase;
    //check if data is already present or not
    final List<Map<String, dynamic>> maps =
        await dbClient.rawQuery("SELECT * FROM $transTable ");
    if (maps.length > 4) {
      return true;
    }
    return false;
  }

  Future<void> delete(String title) async {
    var dbClient = await recentDatabase;
    return await dbClient.delete(
      transTable,
      where: '$colTitle = ?',
      whereArgs: [title],
    );
  }

  Future<void> addingDatabase(AudioBookModel transaction) async {
    var dbClient = await recentDatabase;
    bool _istrue = await _isPresent(transaction.title);
    _istrue = await _isMorethanFour();
    if (!_istrue) {
      await dbClient.insert(
        transTable,
        transaction.tomap(),
      );
    }
  }
}
