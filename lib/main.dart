import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:zing/config/routes/page_routes.dart';
import 'package:zing/config/theme/app_theme.dart';
import 'package:zing/data/data_sources/object_box-data_source/object_box_data_source.dart';
import 'package:zing/presentation/pages/splash/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init object box
  await ObjectBoxDataSource.create();
  //notification player
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Zing playback',
    androidNotificationOngoing: true,
    androidShowNotificationBadge: true,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Zing",
      theme: AppTheme.theme(context),
      routes: pageRoutes,
      initialRoute: SplashPage.routeName,
    );
  }
}
