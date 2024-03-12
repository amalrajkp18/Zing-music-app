import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zing/core/colors/app_colors.dart';
import 'package:zing/core/utils/app_responsive_units.dart';

class AboutDescTextWidget extends StatelessWidget {
  const AboutDescTextWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.nunito(
        color: AppColors.grey,
        fontSize: context.width(16),
      ),
    );
  }
}
