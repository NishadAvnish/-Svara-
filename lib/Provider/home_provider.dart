import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:svara/Model/audiobook_model.dart';

class HomeProvider with ChangeNotifier {
  Firestore firestoreRefernce = Firestore.instance;
  int _count = 0;
  int _currentCount = 0;
  int _previousCount = 0;

  List<AudioBookModel> _audioList = [];
  List<AudioBookModel> get audioList {
    return [..._audioList];
  }

  Future<void> fetchAudio() async {
    if (_count == 0) {
      final _snapshot =
          await firestoreRefernce.collection("Books").getDocuments();
      if (_snapshot != null) {
        _snapshot.documents.forEach((doc) {
          _audioList.add(AudioBookModel(
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
    }
    _count = 1;
  }
}
