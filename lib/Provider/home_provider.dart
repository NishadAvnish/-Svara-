import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:svara/Model/audiobook_model.dart';

class HomeProvider with ChangeNotifier {
  Firestore firestoreRefernce = Firestore.instance;
  int _count = 0;
  int _currentCount = 0;
  int _previousCount = 0;

  List<AudioBookModel> _audioList = [];
  List<AudioBookModel> _searchedList = [];
  List<AudioBookModel> _fromDatabaseList = [];

  List<AudioBookModel> get audioList {
    return [..._audioList];
  }

  void searched(String searchedTitle) {
    _searchedList.clear();
    _fromDatabaseList.forEach((item) {
      if (item.title.toLowerCase().contains(searchedTitle.toLowerCase())) {
        _searchedList.add(item);
      }
    });

    _audioList = _searchedList;
    print("SearchedList ${_audioList.length}");
    notifyListeners();
  }

  Future<void> fetchAudio() async {
    await Future.delayed(Duration(milliseconds: 1));
    _fromDatabaseList = [
      AudioBookModel(
          audioUrl: "Assets/Audio/All Marketers Are Liar.mp3",
          imageUrl:
              "https://images.unsplash.com/photo-1587613725874-d9a1e8e23f6b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
          title: "All Marketers are Liars"),
      AudioBookModel(
          audioUrl: "Assets/Audio/Deep Work.mp3",
          imageUrl:
              "https://images.unsplash.com/photo-1587613725874-d9a1e8e23f6b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
          title: "Deep Work"),
      AudioBookModel(
          audioUrl: "Assets/Audio/law of power.mp3",
          imageUrl:
              "https://images.unsplash.com/photo-1587613725874-d9a1e8e23f6b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
          title: "Law Of Power"),
      AudioBookModel(
          audioUrl: "Assets/Audio/The Enterpreneur Roller Coaster.mp3",
          imageUrl:
              "https://images.unsplash.com/photo-1587613725874-d9a1e8e23f6b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
          title: "The Enterpreneur Roller Coaster"),
    ];
    _audioList = _fromDatabaseList;
    notifyListeners();
  }

  // Future<void> fetchAudio() async {
  //   if (_count == 0) {
  //     final _snapshot =
  //         await firestoreRefernce.collection("Books").getDocuments();
  //     if (_snapshot != null) {
  //       _snapshot.documents.forEach((doc) {
  //         _audioList.add(AudioBookModel(
  //           title: doc.documentID,
  //           imageUrl: doc["imageUrl"],
  //           audioUrl: doc["audioUrl"],
  //         ));

  //         // this below code is to provide the UI with 20 data and so user can see some sort of data
  //         if (_currentCount % 20 == 0 && _previousCount < _currentCount) {
  //           notifyListeners();
  //           _previousCount = _currentCount;
  //         }
  //         _currentCount += 1;
  //       });
  //     }
  //     notifyListeners();
  //   }
  //   _count = 1;
  // }
}
