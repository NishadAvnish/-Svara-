import 'package:flutter/material.dart';
import 'package:svara/Screen/favourite.dart';
import 'package:svara/Screen/player.dart';
import 'Screen/home.dart';
import 'Utils/color_config.dart';

class ScreenSelector extends StatefulWidget {
  @override
  _ScreenSelectorState createState() => _ScreenSelectorState();
}

class _ScreenSelectorState extends State<ScreenSelector> {
  int _selectedIndex;
  List<Widget> screens;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screens = [
      Home(
        scrollController: _scrollController,
        currentindex: _selectedIndex,
      ),
      Home(
        scrollController: _scrollController,
        currentindex: _selectedIndex,
      ),
      Player(),
      Favourites(),
    ];
    return Scaffold(
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
        selectedLabelStyle: TextStyle(fontSize: 15),
        selectedItemColor: selectedNavTextColor,
        unselectedLabelStyle: TextStyle(fontSize: 0),
        items: [
          _navigationItems("Home", Icons.home, 0),
          _navigationItems("Search", Icons.search, 1),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              title: Text("play"),
              backgroundColor: uniqueColor.withOpacity(0.9)),
          _navigationItems("Favourites", Icons.favorite_border, 3),
        ],
        currentIndex: _selectedIndex,
        onTap: (int currentIndex) {
          // to move the list to top for searchbar
          if (currentIndex == 1 && _selectedIndex<=1) {
            _scrollController.animateTo(0.0,
                duration: Duration(milliseconds: 200),
                curve: Curves.decelerate);
          }
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
