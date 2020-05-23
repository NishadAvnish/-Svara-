import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:svara/Utils/color_config.dart';
import 'package:svara/Widgets/itemlist.dart';
import 'package:svara/Widgets/recently_played.dart';
import 'package:svara/Widgets/search.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () =>FocusScope.of(context).unfocus(),
        child: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: _mediaQuery.size.height * 0.3,
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
              padding: EdgeInsets.only(left: 12.0, right: 0),
              child: Column(children: <Widget>[
                SizedBox(height: 25),
                Search(),
                SizedBox(height: 25),
                RecentlyPlayed(),
              ]),
            )),
          ),
          SliverPadding(
              padding: EdgeInsets.only(left: 12,right: 12),
              sliver: SliverPersistentHeader(
                  pinned: true,
                  delegate: HeaderDelegate(minExtent: 44, maxExtent: 44))),
          SliverPadding(
            padding: EdgeInsets.only(left: 12),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: ItemList(index),
              );
            }, childCount: 31)),
          )
        ]),
      ),
    );
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final minExtent, maxExtent;

  HeaderDelegate({this.minExtent, this.maxExtent});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 12),
      child:Text(
          'Explore',
          style: TextStyle(
            fontFamily: 'Malgun Gothic',
            fontSize: 17,
            color: Colors.white,
            letterSpacing: 0.03,
          ),
          textAlign: TextAlign.left,
          
        ),
      
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
