import 'package:flutter/material.dart';
import 'package:svara/Utils/color_config.dart';
import 'package:svara/Widgets/itemlist.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:12.0),
            child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:8.0),
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
            SizedBox(height: 12,),
            Expanded(child: ListView.separated(itemBuilder: (context,index)=>HomeItemList(index:index,flag:0), itemCount: 30, separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height:15);
            },)),
        ],
      ),
          ),
    );
  }
}
