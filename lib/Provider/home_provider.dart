import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:svara/Model/audiobook_model.dart';

class HomeProvider with ChangeNotifier {
  Firestore firestoreRefernce = Firestore.instance;
  int _count = 0;
  int _currentCount = 0;
  int _previousCount = 0;
  bool _searched = false;

  List<AudioBookModel> _searchedList = [];
  List<AudioBookModel> _fromDatabaseList = [];

  List<AudioBookModel> get audioList {
    if (_searched) {
      return [..._searchedList];
    }
    return [..._fromDatabaseList];
  }

  void searched(String searchedTitle) {
    _searchedList.clear();
    _fromDatabaseList.forEach((item) {
      if (item.title
          .trim()
          .toLowerCase()
          .contains(searchedTitle.toLowerCase())) {
        _searchedList.add(item);
      }
    });

    _searched = true;
    notifyListeners();
  }

  Future<void> fetchAudio() async {
    //this count will stop the refetching of same data from firebase again and again whenever the user moves to HomePage
    if (_count == 0) {
      try {
        final _snapshot =
            await firestoreRefernce.collection("Books").getDocuments();
        if (_snapshot != null) {
          _snapshot.documents.forEach((doc) {
            _fromDatabaseList.add(AudioBookModel(
              title: doc.documentID,
              imageUrl: doc["imageUrl"],
              audioUrl: doc["audioUrl"],
            ));

            // this below code is to provide the UI with 20 data and so user can see some sort of data
            if (_currentCount % 20 == 0 && _previousCount < _currentCount) {
              notifyListeners();
              _previousCount = _currentCount;
            }
            _currentCount += 1;
          });
        }
        notifyListeners();
      } catch (e) {
        print(e);
      }
    }
    _count = 1;
  }
}
