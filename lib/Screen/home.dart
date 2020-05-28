import 'package:flutter/material.dart';
import 'package:svara/Widgets/itemlist.dart';
import 'package:svara/Widgets/recently_played.dart';
import 'package:svara/Widgets/search.dart';

class Home extends StatefulWidget {
  final ScrollController scrollController;
  final int currentindex;
  const Home({this.scrollController, this.currentindex});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    if (widget.currentindex == 1) {
      FocusScope.of(context).requestFocus(_focusNode);
    }
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(focusPrevious: true),
        child: CustomScrollView(
            controller: widget.scrollController,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: _mediaQuery.size.height * 0.3,
                flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                  padding: EdgeInsets.only(left: 12.0, right: 0),
                  child: Column(children: <Widget>[
                    SizedBox(height: 25),
                    Search(focusNode: _focusNode),
                    SizedBox(height: 25),
                    RecentlyPlayed(),
                  ]),
                )),
              ),
              SliverPadding(
                  padding: EdgeInsets.only(left: 12, right: 12),
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
      child: Text(
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
