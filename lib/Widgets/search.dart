import 'package:flutter/material.dart';
import 'package:svara/Utils/color_config.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(20)
            ),
            child: TextField(
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: uniqueColor)),
              ),
            ),
          ),
        ),
        IconButton(
            icon: Icon(
              Icons.more_vert,
              color: whiteColor,
            ),
            onPressed: () {}),
      ],
    );
  }
}
