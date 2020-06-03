import 'package:flutter/material.dart';
import 'package:svara/Utils/color_config.dart';
import 'package:svara/Widgets/player_widget.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  int _currentIndex;

  @override
  void initState() {
    _currentIndex = 2;
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
        child: CustomScrollView(slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: _mediaQuery.size.height * 0.51,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: whiteColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: whiteColor,
                    ),
                    onPressed: () {}),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.only(
                    top: _mediaQuery.padding.top + kToolbarHeight,
                    left: 12,
                    right: 12),
                child: Column(
                  children: <Widget>[
                    PlayerWidget(),
                    // Text(playList)
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 12.0, bottom: 5),
              child: Text(
                'Up Next',
                style: TextStyle(
                    fontFamily: 'Malgun Gothic',
                    fontSize: 17,
                    color: Colors.white,
                    letterSpacing: 0.03,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return index == _currentIndex
                      ? Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: uniqueColor),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white24),
                          child: _listTile(context),
                        )
                      : _listTile(context);
                },
                childCount: 15,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

Widget _listTile(BuildContext context) {
  final _size = MediaQuery.of(context).size;
  return ListTile(
    leading: Container(
      constraints: BoxConstraints(
        maxWidth: 40.0,
        maxHeight: 40.0,
        minWidth: 30.0,
        minHeight: 30.0,
      ),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(12.0),
        shape: BoxShape.circle,
        image: DecorationImage(
          image: const AssetImage('Assets/Images/b.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    title: Padding(
      padding: EdgeInsets.only(left: _size.width * 0.1),
      child: Text(
        'All marketer are liar',
        style: TextStyle(
          fontFamily: 'Arial',
          fontSize: 13.5,
          color: Colors.black54,
          letterSpacing: 0.06,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
    ),
  );
}
