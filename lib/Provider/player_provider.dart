import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

import '../Model/audiobook_model.dart';
import '../Model/audiobook_model.dart';

class PlayerProvider with ChangeNotifier {
  AssetsAudioPlayer _audioAssetPlayer;
  int _currentPlayingIndex = 0;
  //this previousplayingindex take cares of last clicked audioitem index
  int _previousplayingIndex = -1;

  List<Audio> _homePlayList = [];
  List<AudioBookModel> _audioBookList = [];

  PlayerProvider([audioList]) {
    if (audioList != null) {
      _audioBookList = audioList;

      for (int i = 0; i < audioList.length; i++) {
        _homePlayList.add(Audio.network(audioList[i].audioUrl));
      }
    }
  }

  List<Audio> get playList {
    return _homePlayList;
  }

  int get currentPlayingIndex {
    return _currentPlayingIndex;
  }

  int get previousPlayingIndex {
    return _previousplayingIndex;
  }

  void changeCurrentPlayingIndex(int index) {
    _currentPlayingIndex = index;
    notifyListeners();
    _previousplayingIndex = _currentPlayingIndex;
  }

  AssetsAudioPlayer get audioAssetPlayer {
    if (_audioAssetPlayer == null) {
      _audioAssetPlayer = AssetsAudioPlayer();
    }
    return _audioAssetPlayer;
  }

  audioFunc({String flag}) {
    //this if check whether the request is from playing button or not if it is from playing button then it will play the last listened media
    if (flag != "now playing") {
      _audioAssetPlayer.open(Playlist(audios: _homePlayList),
          autoStart: true, showNotification: false);
    }
  }

  void playatindex(AudioBookModel audio) {
    int _index = _audioBookList
        .indexWhere((audioItem) => audioItem.title == audio.title);
    changeCurrentPlayingIndex(_index);
    _audioAssetPlayer.playlistPlayAtIndex(_index);
  }

  void movePrevOrNext(String flag, [index]) {
    if (flag == "prev") {
      changeCurrentPlayingIndex(_currentPlayingIndex - 1);
    } else if (flag == "next") {
      changeCurrentPlayingIndex(_currentPlayingIndex + 1);
    } else {
      if (index != null) {
        changeCurrentPlayingIndex(index);
      }
    }
    _audioAssetPlayer.playlistPlayAtIndex(_currentPlayingIndex);
  }
}
