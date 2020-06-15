import 'package:flutter/material.dart';
import 'package:svara/Database/recently_sqldatabase.dart';
import 'package:svara/Model/audiobook_model.dart';

class RecentlyProvider with ChangeNotifier {
  List<AudioBookModel> _recentlyList = [];

  List<AudioBookModel> get recentlyList {
    return [..._recentlyList.reversed];
  }

  RecentlyDatabasehelper _recentDatabaseHelper = RecentlyDatabasehelper();

  Future<void> getRecent() async {
    _recentlyList = await _recentDatabaseHelper.getRecently();
    notifyListeners();
  }

  Future<void> addtoDatabase(AudioBookModel transactionItem) async {
    try {
      await RecentlyDatabasehelper().addingDatabase(transactionItem);
    } catch (e) {
      print(e);
    }
    await getRecent();
  }
}
