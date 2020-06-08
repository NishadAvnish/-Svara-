import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        // ChangeNotifierProxyProvider<HomeProvider, PlayerProvider>(
        //     create: (context) => PlayerProvider(),
        //     update: (context, homeProvider, playerProvider) =>
        //         PlayerProvider(homeProvider.audioList)),
        ChangeNotifierProvider.value(value: FavouriteProvider()),
        ChangeNotifierProxyProvider2<HomeProvider,FavouriteProvider, PlayerProvider>(
            create: (context) => PlayerProvider(),
            update: (context, homeProvider,favouriteProvider, playerProvider) =>
                PlayerProvider(homeProvider.audioList,favouriteProvider.favouriteList)),
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
