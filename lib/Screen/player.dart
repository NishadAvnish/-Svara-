import 'package:flutter/material.dart';
import 'package:svara/Utils/color_config.dart';
import 'package:vector_math/vector_math_64.dart' as maths;

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  double _currentValue;
  bool _isPlaying;
  @override
  void initState() {
    _currentValue = 0;
    _isPlaying = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: screenGradientColor,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(top: _mediaQuery.padding.top, left: 12, right: 12),
        child: Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: whiteColor,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: whiteColor,
                      ),
                      onPressed: () {})
                ]),
            SizedBox(height: 12),
            Container(
              height: _mediaQuery.size.height * 0.23,
              width: _mediaQuery.size.width * 0.456,
              padding: const EdgeInsets.all(8.0),
              constraints: BoxConstraints(
                  minHeight: 120, minWidth: 120, maxHeight: 180, maxWidth: 180),
              decoration: BoxDecoration(
                  border: Border.all(width: 3, color: uniqueColor),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("Assets/Images/c.jpg"),
                      fit: BoxFit.fill)),
            ),
            SizedBox(height: 15),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Slider(
                  max: 10,
                  min: 0,
                  activeColor: uniqueColor,
                  inactiveColor: Colors.white,
                  value: _currentValue,
                  onChanged: (value) {
                    setState(() {
                      _currentValue = value;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Transform.rotate(
                    angle: maths.radians(180),
                    alignment: Alignment.center,
                    child: IconButton(
                        icon: Icon(
                          Icons.play_arrow,
                          size: 35,
                        ),
                        onPressed: null)),
                Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: IconButton(
                        icon: _isPlaying
                            ? Icon(Icons.play_arrow)
                            : Icon(Icons.pause),
                        onPressed: () {
                          setState(() {
                            _isPlaying = !_isPlaying;
                          });
                        })),
                IconButton(
                    icon: Icon(Icons.play_arrow, size: 35), onPressed: null)
              ],
            ),

            // Text(playList)
          ],
        ),
      ),
    ));
  }
}
