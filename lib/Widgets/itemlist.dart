import 'package:flutter/material.dart';
import 'package:svara/Screen/player.dart';

import '../Utils/color_config.dart';
import '../page_transition.dart';

class HomeItemList extends StatelessWidget {
  final int index;
  final int flag;
  final item;
  final int length;

  const HomeItemList({this.index, this.flag, this.item, this.length});

  @override
  Widget build(BuildContext context) {
    // final _size = MediaQuery.of(context).size;
    return index == length
        ? Container(
            height: kBottomNavigationBarHeight - 10,
          )
        : InkWell(
            onTap: () {
              Navigator.of(context).push(fadeTransition(
                  child: Player(
                homeclickedIndex: index,
                flag: flag == 0 ? "favourite playing" : "new playing",
              
              )));
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 50.0,
                          maxHeight: 50.0,
                          minWidth: 40.0,
                          minHeight: 40.0,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(item.imageUrl),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                              width: 1.0, color: const Color(0xff707070)),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7),
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
                    ],
                  ),
                  flag == 0
                      ? IconButton(
                          icon: Icon(Icons.favorite,color: uniqueColor,), onPressed: () {})
                      : Container(),
                ]),
          );
  }
}
