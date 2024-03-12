import 'package:flutter/material.dart';
import 'package:zing/presentation/pages/main_page/main_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_provider.g.dart';

@riverpod
Future<Widget> splash(SplashRef ref) async {
  //request permmission
  final PermissionStatus storageStatus = await Permission.storage.request();

  if (storageStatus.isGranted) {
    // Permission granted, proceed with storage access
    return await Future.delayed(
      const Duration(seconds: 3),
      () => const MainPage(),
    );
  } else if (storageStatus.isDenied) {
    // Permission denied permanently, open app settings
    await openAppSettings();
    if (storageStatus.isGranted) {
      return const MainPage();
    } else {
      // Handle permission status not granted
      throw "A error occured for storage permmisson denied";
    }
  } else {
    // Handle other permission status (denied, etc.)
    throw "A error occured for permmission handling";
  }
}
