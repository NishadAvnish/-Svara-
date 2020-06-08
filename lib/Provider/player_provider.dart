import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

class PlayerProvider with ChangeNotifier {
  AssetsAudioPlayer _audioAssetPlayer;
  int _currentPlayingIndex = 0;
  //this previousplayingindex take cares of last clicked audioitem index
  int _previousplayingIndex = -1;

  List<Audio> _homePlayList = [];
  List<Audio> _favouritePlaylist = [];
  bool _isFavouritePlaying = false;

  PlayerProvider([audioList, favouriteList]) {
    if (audioList != null) {
      for (int i = 0; i < audioList.length; i++) {
        _homePlayList.add(Audio.network(audioList[i].audioUrl));
      }
    }
    if (favouriteList != null) {
      for (int i = 0; i < favouriteList.length; i++) {
        _favouritePlaylist.add(Audio.network(favouriteList[i].audioUrl));
      }
    }
  }

  List<Audio> get playList {
    if (_isFavouritePlaying) {
      return _favouritePlaylist;
    } else
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
      if (flag == "favourite playing") {
        print("Avnish");
        _audioAssetPlayer = null;
        print("oldAsset${_audioAssetPlayer}");

        print("newassetplayer${audioAssetPlayer}");

        audioAssetPlayer.open(Playlist(audios: _favouritePlaylist),
            autoStart: false, showNotification: false);
        _audioAssetPlayer.playlistPlayAtIndex(_currentPlayingIndex);
      } else {
        _audioAssetPlayer.open(Playlist(audios: _homePlayList),
            autoStart: true, showNotification: false);
      }
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
