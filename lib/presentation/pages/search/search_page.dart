import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  page title
        title: Text(
          "Search",
          style: GoogleFonts.nunito(
            color: AppColors.white,
            fontSize: context.width(24),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width(10)),
        child: Column(
          children: [
            Container(
              width: context.width(420),
              height: context.height(60),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                  context.width(10),
                ),
              ),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What do you want to listen to ?',
                    hintStyle: GoogleFonts.nunito(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: context.width(18),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.black,
                      size: context.width(40),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
