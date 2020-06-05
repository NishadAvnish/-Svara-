import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:svara/Model/audiobook_model.dart';

class PlayerProvider with ChangeNotifier {
  AssetsAudioPlayer _audioAssetPlayer;
  int _count = 0;
  int _currentPlayingIndex = 0;
  //this previousplayingindex take cares of last clicked audioitem index
  int _previousplayingIndex = -1;
  List<AudioBookModel> audioList = [];
  List<Audio> _playList = [];
  PlayerProvider([audioList]) {
    if (audioList != null) {
      this.audioList = audioList;
      for (int i = 0; i < this.audioList.length; i++) {
        _playList.add(Audio.network(this.audioList[i].audioUrl));
      }
    }
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
  }

  AssetsAudioPlayer get audioAssetPlayer {
    if (_audioAssetPlayer == null) {
      _audioAssetPlayer = AssetsAudioPlayer();
    }
    return _audioAssetPlayer;
  }

  audioFunc() {
    _audioAssetPlayer.open(Playlist(audios: _playList),
        autoStart: false, showNotification: false);
    _audioAssetPlayer.playlistPlayAtIndex(_currentPlayingIndex);
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
