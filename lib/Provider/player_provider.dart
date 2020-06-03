import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

class PlayerProvider with ChangeNotifier {
  AssetsAudioPlayer _audioAssetPlayer;
  int _count = 0;

  AssetsAudioPlayer get audioAssetPlayer {
    if (_audioAssetPlayer == null) {
      _audioAssetPlayer = AssetsAudioPlayer();
    }
    return _audioAssetPlayer;
  }

  int get count {
    return _count;
  }

  audioFunc(Audio audio) {
    if (_count == 0) {
      _audioAssetPlayer.open(audio, showNotification: true);
      _count = 1;
    }

    _audioAssetPlayer.playOrPause();
  }
}
