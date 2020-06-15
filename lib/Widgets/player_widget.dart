import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svara/Provider/favourite_provider.dart';
import 'package:svara/Provider/home_provider.dart';
import 'package:svara/Provider/player_provider.dart';
import 'package:svara/Utils/color_config.dart';
import 'package:vector_math/vector_math_64.dart' as maths;

import '../Provider/favourite_provider.dart';

class PlayerWidget extends StatefulWidget {
  final homeClickedIndex;
  final String flag;
  const PlayerWidget({this.homeClickedIndex, this.flag});

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  AssetsAudioPlayer _audioAssetPlayer;
  int _audioDuration = 0;
  int _currentDuration = 0;
  String _timeLeft = "00:00";
  PlayerProvider _playerProvider;
  FavouriteProvider _favouriteProvider;
  HomeProvider _homeProvider;
  int _currentPlayingIndex;

  @override
  void initState() {
    super.initState();
    _listenToPlayer();
  }

  void _listenToPlayer() {
    if (widget.flag != "now playing") {
      if (widget.flag == "new playing") {
        Provider.of<PlayerProvider>(context, listen: false).playlist(
            Provider.of<HomeProvider>(context, listen: false).audioList,
            widget.flag);
      } else {
        Provider.of<PlayerProvider>(context, listen: false).playlist(
            Provider.of<FavouriteProvider>(
              context,
              listen: false,
            ).favouriteList,
            widget.flag);
      }
    }

    _audioAssetPlayer =
        Provider.of<PlayerProvider>(context, listen: false).audioAssetPlayer;

    if (_audioAssetPlayer != null) {
      _audioAssetPlayer.current.listen((playing) {
        if (mounted) {
          _audioDuration = playing.audio.duration.inMilliseconds;
        }
      });

      _audioAssetPlayer.currentPosition.listen((currentPosition) {
        if (mounted) {
          _currentDuration = currentPosition.inMilliseconds;

          setState(() {
            _timeLeft = formatTime(_audioDuration - _currentDuration);
          });
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _favouriteProvider = Provider.of<FavouriteProvider>(context, listen: false);
    _playerProvider = Provider.of<PlayerProvider>(context, listen: true);

    //this if condition help in preventing the reseting of assetAudioPlayer on clicking same audio item
    if (_playerProvider.previousPlayingIndex != _currentPlayingIndex) {
      currentPlaying();
    }

    super.didChangeDependencies();
  }

  void currentPlaying() {
    // if (widget.flag == "favourite playing") {
    //   _playerProvider.findAndPlay(
    //       _favouriteProvider.favouriteList[widget.homeClickedIndex]);
    // }

    _playerProvider.audioFunc(flag: widget.flag);

    setState(() {
      _currentPlayingIndex = _playerProvider.currentPlayingIndex;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: _mediaQuery.size.height * 0.23,
          width: _mediaQuery.size.width * 0.456,
          padding: const EdgeInsets.all(8.0),
          constraints: BoxConstraints(
              minHeight: 40, minWidth: 40, maxHeight: 180, maxWidth: 180),
          decoration: BoxDecoration(
              border: Border.all(width: 3, color: uniqueColor),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(widget.flag == "new playing"
                      ? _homeProvider.audioList[_currentPlayingIndex].imageUrl
                      : _favouriteProvider
                          .favouriteList[_currentPlayingIndex].imageUrl),
                  fit: BoxFit.fill)),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          widget.flag == "new playing"
              ? _homeProvider.audioList[_currentPlayingIndex].title
              : _favouriteProvider.favouriteList[_currentPlayingIndex].title,
          style: TextStyle(
            fontFamily: 'Malgun Gothic',
            fontSize: 20,
            color: whiteColor,
            letterSpacing: 0.1,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(
                child: Slider(
                    min: 0,
                    max: _audioDuration.toDouble(),
                    activeColor: uniqueColor,
                    inactiveColor: Colors.white,
                    value: _currentDuration.toDouble(),
                    onChanged: (value) {
                      _audioAssetPlayer
                          .seek(Duration(milliseconds: value.toInt()));

                      setState(() {
                        _currentDuration = value.toInt();
                      });
                    }),
              ),
              Text(
                _timeLeft,
                style: TextStyle(color: whiteColor),
              ),
            ])),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.shuffle,
                  size: 25,
                  color: _audioAssetPlayer.isShuffling.value
                      ? uniqueColor
                      : Colors.grey),
              onPressed: widget.flag == "now playing"
                  ? null
                  : () {
                      _audioAssetPlayer.toggleShuffle();
                      setState(() {});
                    },
            ),
            // this icon is for previous song in playlist

            Transform.rotate(
              angle: maths.radians(180),
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  size: 35,
                ),
                onPressed: (_currentPlayingIndex > widget.homeClickedIndex &&
                        widget.flag != "now playing")
                    ? () {
                        _playerProvider.movePrevOrNext("prev");
                      }
                    : null,
              ),
            ),
            Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: PlayerBuilder.isBuffering(
                    player: _audioAssetPlayer,
                    builder: (context, isBuffering) => isBuffering
                        ? Center(
                            child: CircularProgressIndicator(
                            backgroundColor: uniqueColor,
                          ))
                        : PlayerBuilder.isPlaying(
                            player: _audioAssetPlayer,
                            builder: (context, isPlaying) {
                              return IconButton(
                                  icon: isPlaying
                                      ? Icon(Icons.pause)
                                      : Icon(Icons.play_arrow),
                                  onPressed: () {
                                    _audioAssetPlayer.playOrPause();
                                  });
                            }))),
            // this icon is for next song in playlist
            IconButton(
              icon: Icon(Icons.play_arrow, size: 35),
              onPressed:
                  (_playerProvider.playList.length > _currentPlayingIndex + 1 &&
                          widget.flag != "now playing")
                      ? () {
                          _playerProvider.movePrevOrNext("next");
                        }
                      : null,
            ),
            IconButton(
              icon: Icon(
                Icons.playlist_add,
                size: 25,
              ),
              onPressed: () async {
                Provider.of<FavouriteProvider>(context, listen: false)
                    .addtoDatabase(_homeProvider
                        .audioList[_playerProvider.currentPlayingIndex]);
              },
            )
          ],
        ),
      ],
    );
  }

  // to format the time in hous: minute:seconds
  String formatTime(int milliseconds) {
    final minutes = milliseconds / 60000;

    String time = "";

    // this will add seconds in time
    time = ((minutes - int.parse(minutes.toString().split(".")[0])) * 60)
            .toString()
            .split(".")[0] +
        time;

    final hours = minutes.toInt() / 60;
    // this will add minutes in time
    time = ((hours - int.parse(hours.toString().split(".")[0])) * 60)
            .toString()
            .split(".")[0] +
        ":" +
        time;
    // this will add hours in time if hourse is not 0
    time =
        hours.toInt() == 0 ? time : hours.toString().split(".")[0] + ":" + time;

    return time;
  }
}
