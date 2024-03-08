import 'package:flutter/material.dart';
import 'package:music_app/presentation/pages/library/liked_songs_page.dart';
import 'package:music_app/presentation/pages/music_player/music_player_page.dart';
import 'package:music_app/presentation/pages/splash/splash_page.dart';

final Map<String, WidgetBuilder> pageRoutes = {
  SplashPage.routeName: (context) => const SplashPage(),
  MusicPlayerPage.routeName: (context) => const MusicPlayerPage(),
  LikedSongsPage.routeName: (context) => const LikedSongsPage(),
};
