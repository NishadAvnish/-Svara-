import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svara/Provider/favourite_provider.dart';
import 'package:svara/Utils/color_config.dart';
import 'package:svara/Widgets/itemlist.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  bool _isLoading;
  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    callFuture();
  }

  callFuture() async {
    await Provider.of<FavouriteProvider>(context, listen: true).getFavourite();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // Databasehelper().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _favouritesList =
        Provider.of<FavouriteProvider>(context).favouriteList;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'FAVOURITES',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 18,
                  color: whiteColor,
                  letterSpacing: 0.1,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                            backgroundColor: uniqueColor))
                    : _favouritesList.length < 1
                        ? Center(
                            child: Text("No Data Found !!",
                                style: TextStyle(color: whiteColor)),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) => HomeItemList(
                              index: index,
                              flag: 0,
                              length: _favouritesList.length,
                              item: _favouritesList[index],
                            ),
                            itemCount: _favouritesList.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(height: 15);
                            },
                          )),
          ],
        ),
      ),
    );
  }
}
