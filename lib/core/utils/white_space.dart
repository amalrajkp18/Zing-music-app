import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';

class WhiteSpace {
  static Widget space({
    required BuildContext context,
    double height = 0,
    double width = 0,
  }) {
    return SizedBox(
      width: context.width(width),
      height: context.height(height),
    );
  }
}
