import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svara/Provider/player_provider.dart';
import 'package:svara/Utils/color_config.dart';
import 'package:vector_math/vector_math_64.dart' as maths;

class PlayerWidget extends StatefulWidget {
  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  bool _isPlaying;
  AssetsAudioPlayer _audioAssetPlayer;
  int _audioDuration = 0;
  int _currentDuration = 0;
  String _timeLeft = "00:00";

  @override
  void initState() {
    super.initState();
    _listenerToPlayer();
    _isPlaying = true;
  }

  void _listenerToPlayer() {
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
  void dispose() {
    super.dispose();
  }

  final audio = Audio(
    "Assets/Audio/mpd.mp3",
    metas: Metas(
      title: "Country",
    ),
  );

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

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _playerProvider = Provider.of<PlayerProvider>(context);
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
                  image: AssetImage("Assets/Images/c.jpg"), fit: BoxFit.fill)),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'The Art Of Public Speaking',
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
              onPressed: () {
                _audioAssetPlayer.toggleShuffle();
                setState(() {});
              },
            ),
            Transform.rotate(
              angle: maths.radians(180),
              alignment: Alignment.center,
              child: IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    size: 35,
                  ),
                  onPressed: null),
            ),
            Container(
              height: 50,
              width: 50,
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: IconButton(
                  icon: _isPlaying ? Icon(Icons.play_arrow) : Icon(Icons.pause),
                  onPressed: () {
                    _playerProvider.audioFunc(audio);
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  }),
            ),
            IconButton(icon: Icon(Icons.play_arrow, size: 35), onPressed: null),
            IconButton(
                icon: Icon(Icons.loop,
                    size: 25,
                    color: _audioAssetPlayer.isLooping.value
                        ? uniqueColor
                        : Colors.grey),
                onPressed: () {
                  _audioAssetPlayer.toggleLoop();
                  setState(() {});
                }),
          ],
        ),
      ],
    );
  }
}
