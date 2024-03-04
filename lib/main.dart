import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/config/routes/page_routes.dart';
import 'package:music_app/config/theme/app_theme.dart';
import 'package:music_app/presentation/pages/splash/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      theme: AppTheme.theme(),
      routes: pageRoutes,
      initialRoute: SplashPage.routeName,
    );
  }
}
