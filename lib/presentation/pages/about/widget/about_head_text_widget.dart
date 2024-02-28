import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';

class AboutHeadTextWidget extends StatelessWidget {
  const AboutHeadTextWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(
        color: AppColors.white,
        fontWeight: FontWeight.w600,
        fontSize: context.width(20),
      ),
    );
  }
}
