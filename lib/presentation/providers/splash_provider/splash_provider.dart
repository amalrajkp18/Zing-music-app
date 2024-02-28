import 'package:flutter/material.dart';
import 'package:music_app/presentation/pages/main_page/main_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_provider.g.dart';

@riverpod
Future<Widget> splash(SplashRef ref) async {
  return await Future.delayed(
    const Duration(seconds: 3),
    () => const MainPage(),
  );
}
