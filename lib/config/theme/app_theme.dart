import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';

class AppTheme {
  static ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.scaffoldBg,
      fontFamily: GoogleFonts.nunito().fontFamily,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
