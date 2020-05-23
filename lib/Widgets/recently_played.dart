import 'package:flutter/material.dart';
import 'package:svara/Utils/color_config.dart';

class RecentlyPlayed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          itemCount: 2,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
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
                    image: const AssetImage('Assets/Images/b.jpg'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    width: 1.0,
                    color: const Color(0xff707070),
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
