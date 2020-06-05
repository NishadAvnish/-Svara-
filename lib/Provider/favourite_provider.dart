import 'package:flutter/cupertino.dart';
import 'package:svara/Database/sqldtabase.dart';
import 'package:svara/Model/audiobook_model.dart';

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

  Future<void> toggleFavourite(int index, AudioBookModel transactionData) {
    bool _oldStatus = _favouriteList[index].favourite;

    _favouriteList[index].favourite = !_favouriteList[index].favourite;
    notifyListeners();

    if (_favouriteList[index].favourite) {
      try {
        _databasehelper.addtoDatabase(transactionData);
      } catch (e) {
        _favouriteList[index].favourite = _oldStatus;
      }
    } else {
      try {
        _databasehelper.delete(transactionData.title);
      } catch (e) {
        _favouriteList[index].favourite = _oldStatus;
      }
    }

    notifyListeners();
  }

  Future<void> closeDatabase() async {
    await _databasehelper.close();
  }
}
