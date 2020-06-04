import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svara/Screen/favourite.dart';
import 'package:svara/Screen/player.dart';
import 'package:svara/page_transition.dart';
import 'Provider/player_provider.dart';
import 'Screen/home.dart';
import 'Utils/color_config.dart';

class ScreenSelector extends StatefulWidget {
  @override
  _ScreenSelectorState createState() => _ScreenSelectorState();
}

class _ScreenSelectorState extends State<ScreenSelector>
    with SingleTickerProviderStateMixin {
  int _selectedIndex;
  List<Widget> screens;
  AnimationController rotationController;

  @override
  void initState() {
    _selectedIndex = 0;
    rotationController = AnimationController(
        duration: const Duration(seconds: 3),
        reverseDuration: const Duration(seconds: 1),
        vsync: this);

    rotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rotationController.reverse();
      }

      if (status == AnimationStatus.dismissed) {
        rotationController.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screens = [
      Home(),
      Favourites(),
    ];

    final _assetPlayer = Provider.of<PlayerProvider>(context).audioAssetPlayer;

    if (_assetPlayer.isPlaying.value) {
      rotationController.forward();
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(slideTransition(child: Player()));
          },
          child: RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text("Avnish")),
              ))),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: screenGradientColor,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: screens[_selectedIndex],
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _bottomNavigation())
        ],
      ),
    );
  }

  Widget _bottomNavigation() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(18.0)),
      child: BottomNavigationBar(
        backgroundColor: uniqueColor,
        selectedLabelStyle: TextStyle(fontSize: 15),
        selectedItemColor: selectedNavTextColor,
        unselectedLabelStyle: TextStyle(fontSize: 0),
        items: [
          _navigationItems("Home", Icons.home, 0),
          _navigationItems("Favourites", Icons.favorite_border, 1),
        ],
        currentIndex: _selectedIndex,
        onTap: (int currentIndex) {
          setState(() {
            _selectedIndex = currentIndex;
          });
        },
      ),
    );
  }

  BottomNavigationBarItem _navigationItems(
      String itemName, IconData itemIcon, index) {
    return BottomNavigationBarItem(
      backgroundColor: uniqueColor.withOpacity(0.9),
      icon: Icon(itemIcon),
      title: _selectedIndex == index
          ? Builder(builder: (context) {
              return Text(
                itemName,
              );
            })
          : Text(""),
    );
  }
}
