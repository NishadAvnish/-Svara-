import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svara/Screen/favourite.dart';
import 'package:svara/Screen/player.dart';
import 'package:svara/page_transition.dart';
import 'Provider/player_provider.dart';
import 'Screen/home.dart';
import 'Utils/color_config.dart';
import 'Widgets/bottom_sheet.dart';

class ScreenSelector extends StatefulWidget {
  @override
  _ScreenSelectorState createState() => _ScreenSelectorState();
}

class _ScreenSelectorState extends State<ScreenSelector>
    with SingleTickerProviderStateMixin {
  int _selectedIndex;
  List<Widget> screens;
  AnimationController rotationController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screens = [
      Home(),
      Favourites(),
    ];

    final _assetPlayer = Provider.of<PlayerProvider>(context).audioAssetPlayer;

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_assetPlayer == null) {
              _scaffoldKey.currentState.hideCurrentSnackBar();
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Color.fromRGBO(16, 124, 173, 1),
                content: Text('Currently no AudioBook playing'),
                duration: Duration(milliseconds: 1500),
              ));
            } else {
              showBotomSheet(context);
            }
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(
                child: Text(
              "Playing",
              style: TextStyle(fontSize: 12),
            )),
          )),
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
