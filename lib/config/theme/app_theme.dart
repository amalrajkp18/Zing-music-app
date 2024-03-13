import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zing/core/colors/app_colors.dart';
import 'package:zing/core/utils/app_responsive_units.dart';

class AppTheme {
  static ThemeData theme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.scaffoldBg,
      fontFamily: GoogleFonts.nunito().fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        titleTextStyle: GoogleFonts.nunito(
          color: AppColors.white,
          fontSize: context.width(24),
          fontWeight: FontWeight.bold,
        ),
      ),
      primaryTextTheme: TextTheme(
        titleLarge: GoogleFonts.pacifico(
          color: AppColors.white,
          fontSize: context.width(40),
        ),
        titleMedium: GoogleFonts.pacifico(
          color: AppColors.white,
          fontSize: context.width(26),
        ),
        bodySmall: GoogleFonts.nunito(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.nunito(
          color: AppColors.white,
          fontSize: context.width(25),
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.nunito(
          color: AppColors.white,
          fontSize: context.width(15),
          fontWeight: FontWeight.w500,
        ),
        titleSmall: GoogleFonts.nunito(
          color: AppColors.whiteSmokeGrey,
          fontSize: context.width(12),
          fontWeight: FontWeight.normal,
        ),
        bodySmall: GoogleFonts.nunito(
          color: AppColors.white,
          fontSize: context.width(16),
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.elevatedButton,
          fixedSize: Size(
            context.width(200),
            context.height(25),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: GoogleFonts.nunito(
          color: AppColors.black,
          fontWeight: FontWeight.w600,
          fontSize: context.width(18),
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.white,
      ),
      popupMenuTheme: PopupMenuThemeData(
        iconSize: context.width(30),
        color: AppColors.scaffoldBg,
        textStyle: GoogleFonts.nunito(
          color: AppColors.white,
          fontSize: context.width(15),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
