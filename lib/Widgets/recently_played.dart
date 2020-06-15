import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svara/Provider/recently_provider.dart';
import 'package:svara/Screen/player.dart';
import 'package:svara/Utils/color_config.dart';

import '../page_transition.dart';

class RecentlyPlayed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _recentProvider = Provider.of<RecentlyProvider>(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 25),
      Text(
        'Recently Played',
        style: TextStyle(
          fontFamily: 'Malgun Gothic',
          fontSize: 17,
          color: whiteColor,
          letterSpacing: 0.03,
        ),
        textAlign: TextAlign.left,
      ),
      SizedBox(height: 15),
      Container(
        width: _size.width,
        height: _size.height * 0.12,
        constraints: BoxConstraints(
          maxHeight: 100.0,
          minHeight: 70.0,
        ),
        child: ListView.builder(
          itemCount: _recentProvider.recentlyList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(fadeTransition(
                    child: Player(
                  homeclickedIndex: index,
                  flag: "recent playing",
                )));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Container(
                  width: _size.width * 0.33,
                  height: _size.height * 0.12,
                  constraints: BoxConstraints(
                    maxWidth: 130.0,
                    maxHeight: 110.0,
                    minWidth: 100.0,
                    minHeight: 80.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    image: DecorationImage(
                      image: NetworkImage(
                          _recentProvider.recentlyList[index].imageUrl),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      width: 1.0,
                      color: const Color(0xff707070),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ]);
  }
}
