import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svara/Provider/recently_provider.dart';
import 'package:svara/screen_selector.dart';
import 'Provider/favourite_provider.dart';
import 'Provider/home_provider.dart';
import 'Provider/player_provider.dart';

main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomeProvider()),
        ChangeNotifierProvider.value(value: FavouriteProvider()),
        ChangeNotifierProvider.value(value: PlayerProvider()),
        ChangeNotifierProvider.value(value: RecentlyProvider()),
        
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.greenAccent,
          splashColor: Colors.orangeAccent,
        ),
        debugShowCheckedModeBanner: false,
        home: ScreenSelector(),
        // home: Player(),
      ),
    );
  }
}
