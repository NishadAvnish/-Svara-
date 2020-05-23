import 'package:flutter/material.dart';
import 'package:svara/Screen/favourite.dart';
import 'Screen/home.dart';
import 'Utils/color_config.dart';

class ScreenSelector extends StatefulWidget {
  @override
  _ScreenSelectorState createState() => _ScreenSelectorState();
}

class _ScreenSelectorState extends State<ScreenSelector> {
  int _selectedIndex;
  List<Widget> screens;
  @override
  void initState() {
    _selectedIndex = 0;
    screens = [
      Home(),
      Favourites(),
      Favourites(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        // backgroundColor: Colors.white54,
        backgroundColor: Colors.orangeAccent.withOpacity(0.9),
        selectedLabelStyle: TextStyle(fontSize: 15),
        selectedItemColor: selectedNavTextColor,
        unselectedLabelStyle: TextStyle(fontSize: 0),
        items: [
          _navigationItems("Home", Icons.home, 0),
          _navigationItems("Search", Icons.search, 1),
          _navigationItems("Favourites", Icons.favorite_border, 2),
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
