import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  final int index;

  const ItemList(this.index);
  @override
  Widget build(BuildContext context) {
    // final _size = MediaQuery.of(context).size;
    return index==30?Container(height: kBottomNavigationBarHeight-10,): Row(
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
                      // borderRadius: BorderRadius.circular(12.0),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: index % 2 == 0
                            ? const AssetImage('Assets/Images/a.jpg')
                            : const AssetImage('Assets/Images/b.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'All marketer are liar',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 13.5,
                      color: Colors.black54,
                      letterSpacing: 0.06,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
            ]);
      
  }
}
