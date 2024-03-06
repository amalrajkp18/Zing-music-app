import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/presentation/providers/search_provider/search_provider.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width(10)),
      child: Container(
        width: context.width(420),
        height: context.height(60),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(
            context.width(10),
          ),
        ),
        child: Center(
          child: Consumer(
              builder: (context, ref, _) => TextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        ref.read(searchProvider.notifier).searchSong(value);
                      }
                    },
                    style: GoogleFonts.nunito(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: context.width(18),
                    ),
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
                  )),
        ),
      ),
    );
  }
}
