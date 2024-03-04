import 'package:flutter/material.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';

class MusicButtonWidget extends StatelessWidget {
  const MusicButtonWidget({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 30,
    this.iconColor = AppColors.white,
  });
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor,
        size: context.width(size),
      ),
    );
  }
}
