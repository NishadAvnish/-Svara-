import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svara/Provider/home_provider.dart';
import 'package:svara/Utils/color_config.dart';

class Search extends StatelessWidget {
  final FocusNode focusNode;

  const Search({Key key, this.focusNode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(20)),
            child: TextField(
              focusNode: focusNode,
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: uniqueColor)),
              ),
              onChanged: (String text){
                Provider.of<HomeProvider>(context,listen: false).searched(text);
              },
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
