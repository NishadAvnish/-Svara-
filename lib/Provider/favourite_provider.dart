import 'package:flutter/cupertino.dart';
import 'package:svara/Database/sqldtabase.dart';
import 'package:svara/Model/audiobook_model.dart';

import '../Model/audiobook_model.dart';

class FavouriteProvider with ChangeNotifier {
  List<AudioBookModel> _favouriteList = [];

  List<AudioBookModel> get favouriteList {
    return [..._favouriteList];
  }

  Databasehelper _databasehelper = Databasehelper();

  Future<void> addtoDatabase(AudioBookModel transactionItem) async {
    try {
      await Databasehelper().addtoDatabase(transactionItem);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getFavourite() async {
    _favouriteList = await _databasehelper.getFavourite();
    notifyListeners();
  }

  Future<void> removeFromDatabase(AudioBookModel deleteAudio) {
    try {
      _databasehelper.delete(deleteAudio.title);
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  Future<void> closeDatabase() async {
    await _databasehelper.close();
  }
}
