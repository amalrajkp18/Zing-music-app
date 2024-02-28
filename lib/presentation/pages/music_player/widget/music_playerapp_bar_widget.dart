import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/presentation/widgets/music_button_widget.dart';

AppBar musicPlayerAppBarWidget(BuildContext context) {
  return AppBar(
    leading: MusicButtonWidget(
      icon: Icons.arrow_back_ios,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    // song title
    title: Text(
      "Playing",
      style: GoogleFonts.nunito(
        color: AppColors.white,
        fontSize: context.width(22),
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: true,
    actions: [
      MusicButtonWidget(
        icon: Icons.favorite_outline,
        onPressed: () {},
      )
    ],
  );
}
