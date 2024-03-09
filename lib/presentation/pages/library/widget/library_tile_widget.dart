import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/core/utils/white_space.dart';

class LibraryTileWidget extends StatelessWidget {
  const LibraryTileWidget({
    super.key,
    this.isLiked = false,
    required this.title,
    required this.songCount,
    required this.onTap,
    this.trailing,
  });

  final bool isLiked;
  final String title;
  final int songCount;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.width(15),
        vertical: context.height(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: context.width(5)),
          width: context.width(400),
          height: context.height(105),
          child: Row(
            children: [
              // library box
              Container(
                width: context.width(80),
                height: context.height(80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    context.width(10),
                  ),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF42047e),
                      Color(0xFF0974f1),
                    ],
                  ),
                ),
                // is liked or not
                child: isLiked
                    ? Icon(
                        Icons.favorite,
                        size: context.width(50),
                        color: AppColors.white,
                      )
                    : Center(
                        child: Text(
                          title.substring(0, 1).toUpperCase(),
                          style: GoogleFonts.nunito(
                            color: AppColors.white,
                            fontSize: context.width(30),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
              // width spacer
              WhiteSpace.space(context: context, width: 20),
              //libray song title and count
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // music title
                  Text(
                    title,
                    style: GoogleFonts.nunito(
                      color: AppColors.white,
                      fontSize: context.width(17),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // height space
                  WhiteSpace.space(context: context, height: 5),
                  // singer name
                  Text(
                    "$songCount songs for you",
                    style: GoogleFonts.nunito(
                      color: AppColors.whiteSmokeGrey,
                      fontSize: context.width(13),
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
              // width spacer
              const Spacer(),
              // delete button
              trailing == null ? const SizedBox.shrink() : trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
