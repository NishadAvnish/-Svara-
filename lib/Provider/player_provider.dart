import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:svara/Provider/home_provider.dart';
import 'package:svara/Provider/recently_provider.dart';
import 'package:svara/Widgets/recently_played.dart';
import '../Model/audiobook_model.dart';
import 'favourite_provider.dart';

class PlayerProvider with ChangeNotifier {
  AssetsAudioPlayer _audioAssetPlayer;
  int _currentPlayingIndex = 0;
  //this previousplayingindex take cares of last clicked audioitem index
  int _previousplayingIndex = -1;
  String _previousScreenFlag = "";
  bool _isFavouriteScreen = false;
  bool _isRecentfromHomeScreen = false;

  List<Audio> _favouritePlaylist = [];
  List<Audio> _homePlaylist = [];
  List<Audio> _recentPlaylist = [];
  RecentlyProvider _recentProvider;
  HomeProvider _homeProvider;
  FavouriteProvider _favouriteProvider;

  PlayerProvider(
      {RecentlyProvider recentlyProvider,
      HomeProvider homeProvider,
      FavouriteProvider favouriteProvider}) {
    this._recentProvider = recentlyProvider;
    this._favouriteProvider = favouriteProvider;
    this._homeProvider = homeProvider;
  }
  // below two getter is used by now playing widget
  bool get wasRecentPlaying {
    return _isRecentfromHomeScreen;
  }

  bool get wasFavouritePlaying {
    return _isFavouriteScreen;
  }

  List<Audio> get playList {
    return _isRecentfromHomeScreen
        ? _recentPlaylist
        : _isFavouriteScreen ? _favouritePlaylist : _homePlaylist;
  }

  int get currentPlayingIndex {
    return _currentPlayingIndex;
  }

  int get previousPlayingIndex {
    return _previousplayingIndex;
  }

  AssetsAudioPlayer get audioAssetPlayer {
    if (_audioAssetPlayer == null) {
      _audioAssetPlayer = _isRecentfromHomeScreen
          ? AssetsAudioPlayer.withId("recent playing")
          : _isFavouriteScreen
              ? AssetsAudioPlayer.withId("favourite playing")
              : AssetsAudioPlayer.withId("home playing");
    }
    return _audioAssetPlayer;
  }

  void playlist(List<AudioBookModel> _playlist, String currentScreenFlag) {
    currentScreenFlag == "recent playing"
        ? _isRecentfromHomeScreen = true
        : currentScreenFlag == "favourite playing"
            ? _isFavouriteScreen = true
            : () {
                _isFavouriteScreen = false;
                _isRecentfromHomeScreen = false;
              }();

    if (currentScreenFlag != _previousScreenFlag) {
      _favouritePlaylist.clear();
      _homePlaylist.clear();
      for (int i = 0; i < _playlist.length; i++) {
        _isRecentfromHomeScreen
            ? _recentPlaylist.add(Audio.network(_playlist[i].audioUrl))
            : _isFavouriteScreen
                ? _favouritePlaylist.add(Audio.network(_playlist[i].audioUrl))
                : _homePlaylist.add(Audio.network(_playlist[i].audioUrl));
      }
      _previousScreenFlag = currentScreenFlag;
    }
  }

  changeCurrentPlayingIndex(int index) async {
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
