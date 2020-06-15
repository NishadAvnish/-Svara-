import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import '../Model/audiobook_model.dart';

class PlayerProvider with ChangeNotifier {
  AssetsAudioPlayer _audioAssetPlayer;
  int _currentPlayingIndex = 0;
  //this previousplayingindex take cares of last clicked audioitem index
  int _previousplayingIndex = -1;
  String _previousScreenFlag = "";
  bool _isFavouriteScreen = false;

  List<Audio> _favouritePlaylist = [];
  List<Audio> _homePlaylist = [];
  List<AudioBookModel> _audioBookList = [];

  List<Audio> get playList {
    return _isFavouriteScreen ? _favouritePlaylist : _homePlaylist;
  }

  int get currentPlayingIndex {
    return _currentPlayingIndex;
  }

  int get previousPlayingIndex {
    return _previousplayingIndex;
  }

  AssetsAudioPlayer get audioAssetPlayer {
    if (_audioAssetPlayer == null) {
      _audioAssetPlayer = _isFavouriteScreen
          ? AssetsAudioPlayer.withId("favourite playing")
          : AssetsAudioPlayer.withId("home playing");
    }
    return _audioAssetPlayer;
  }

  void playlist(List<AudioBookModel> _playlist, String currentScreenFlag) {
    currentScreenFlag == "favourite playing"
        ? _isFavouriteScreen = true
        : _isFavouriteScreen = false;

    if (currentScreenFlag != _previousScreenFlag) {
      _favouritePlaylist.clear();
      _homePlaylist.clear();
      for (int i = 0; i < _playlist.length; i++) {
        _isFavouriteScreen
            ? _favouritePlaylist.add(Audio.network(_playlist[i].audioUrl))
            : _homePlaylist.add(Audio.network(_playlist[i].audioUrl));
      }

      _previousScreenFlag = currentScreenFlag;
    }
  }

  void changeCurrentPlayingIndex(int index) {
    _currentPlayingIndex = index;
    notifyListeners();
    _previousplayingIndex = _currentPlayingIndex;
  }

  audioFunc({String flag}) {
    //this if check whether the request is from playing button or not if it is from playing button then it will play the last listened media

    if (flag != "now playing") {
      _audioAssetPlayer.open(Playlist(audios: playList),
          autoStart: true, showNotification: false);
      _audioAssetPlayer.playlistPlayAtIndex(_currentPlayingIndex);
    }
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
