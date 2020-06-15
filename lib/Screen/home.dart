import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svara/Model/audiobook_model.dart';
import 'package:svara/Provider/home_provider.dart';
import 'package:svara/Provider/recently_provider.dart';
import 'package:svara/Utils/color_config.dart';
import 'package:svara/Widgets/itemlist.dart';
import 'package:svara/Widgets/recently_played.dart';
import 'package:svara/Widgets/search.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FocusNode _focusNode = FocusNode();
  bool _isLoading;

  List<AudioBookModel> audioList;
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    callProvider();
  }

  callProvider() async {
    await Provider.of<HomeProvider>(context, listen: false).fetchAudio();
    await Provider.of<RecentlyProvider>(context, listen: false).getRecent();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _homeProvider = Provider.of<HomeProvider>(context, listen: true);
    final _recentProvider =
        Provider.of<RecentlyProvider>(context, listen: true);

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: _recentProvider.recentlyList.length > 0 ? 232 : 80,
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
              padding: EdgeInsets.only(left: 12.0, right:12.0),
              child: Column(children: <Widget>[
                SizedBox(height: 25),
                Search(focusNode: _focusNode),
                _recentProvider.recentlyList.length > 0
                    ? RecentlyPlayed()
                    : Container(),
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
            sliver: _isLoading
                ? SliverFillRemaining(
                    child: Center(
                        child: CircularProgressIndicator(
                    backgroundColor: uniqueColor,
                  )))
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: HomeItemList(
                        index: index,
                        flag: 1,
                        item: _homeProvider.audioList[index],
                        length: _homeProvider.audioList.length,
                      ),
                    );
                  }, childCount: _homeProvider.audioList.length)),
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
