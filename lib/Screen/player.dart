import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svara/Model/audiobook_model.dart';
import 'package:svara/Provider/favourite_provider.dart';
import 'package:svara/Provider/home_provider.dart';
import 'package:svara/Provider/player_provider.dart';
import 'package:svara/Provider/recently_provider.dart';
import 'package:svara/Utils/color_config.dart';
import 'package:svara/Widgets/player_widget.dart';

class Player extends StatefulWidget {
  //homeclickedIndex is denoted the cicked index on home page
  final int homeclickedIndex;
  final String flag;
  Player({this.homeclickedIndex, this.flag});
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => callCurrentPlayingProvider());
  }

  void callCurrentPlayingProvider() {
    Provider.of<PlayerProvider>(context, listen: false)
        .changeCurrentPlayingIndex(widget.homeclickedIndex);
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final _recentProvider =
        Provider.of<RecentlyProvider>(context, listen: false);
    final _favouriteProvider =
        Provider.of<FavouriteProvider>(context, listen: false);
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
            expandedHeight: _mediaQuery.size.height * 0.52,
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
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.only(
                    top: _mediaQuery.padding.top + kToolbarHeight,
                    left: 12,
                    right: 12),
                child: Column(
                  children: <Widget>[
                    PlayerWidget(
                      homeClickedIndex: widget.homeclickedIndex,
                      flag: widget.flag,
                    ),
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
                  return (index >= widget.homeclickedIndex)
                      ? Consumer<PlayerProvider>(builder: (_, snapshot, child) {
                          return index == snapshot.currentPlayingIndex
                              ? Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: uniqueColor),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white24),
                                  child: _listTile(
                                      context,
                                      index,
                                      widget.flag == "recent playing"
                                          ? _recentProvider.recentlyList[index]
                                          : widget.flag == "new playing"
                                              ? _homeProvider.audioList[index]
                                              : _favouriteProvider
                                                  .favouriteList[index]),
                                )
                              : _listTile(
                                  context,
                                  index,
                                  widget.flag == "recent playing"
                                      ? _recentProvider.recentlyList[index]
                                      : widget.flag == "new playing"
                                          ? _homeProvider.audioList[index]
                                          : _favouriteProvider
                                              .favouriteList[index]);
                        })
                      : Container();
                },
                childCount: widget.flag == "recent playing"
                    ? _recentProvider.recentlyList.length
                    : widget.flag == "new playing"
                        ? _homeProvider.audioList.length
                        : _favouriteProvider.favouriteList.length,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _listTile(BuildContext context, int index, AudioBookModel item) {
    final _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Provider.of<PlayerProvider>(context, listen: false)
            .changeCurrentPlayingIndex(index);
      },
      child: ListTile(
        leading: Container(
          constraints: BoxConstraints(
            maxWidth: 40.0,
            maxHeight: 40.0,
            minWidth: 30.0,
            minHeight: 30.0,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(item.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: _size.width * 0.1),
          child: Text(
            item.title,
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
      ),
    );
    //}
  }
}
