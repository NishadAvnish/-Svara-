import 'package:flutter/material.dart';
import 'package:svara/screen_selector.dart';

main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.greenAccent,
          splashColor: Colors.orangeAccent,
        ),
        debugShowCheckedModeBanner: false,
        home: ScreenSelector());
  }
}
