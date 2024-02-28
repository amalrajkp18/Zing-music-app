import 'package:flutter/material.dart';

extension AppResponsiveUnits on BuildContext {
  // responsive  height
  double height(double height) {
    return MediaQuery.sizeOf(this).height * (height / 932);
  }

  // responsive  width
  double width(double width) {
    return MediaQuery.sizeOf(this).width * (width / 430);
  }
}
