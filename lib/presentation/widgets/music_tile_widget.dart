import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/core/utils/white_space.dart';

class MusicTileWidget extends StatelessWidget {
  const MusicTileWidget({
    super.key,
    required this.songName,
    required this.singer,
  });
  final String songName;
  final String singer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.width(15),
        vertical: context.height(10),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: context.width(5)),
        width: context.width(350),
        height: context.height(105),
        child: Row(
          children: [
            // music thumbnail
            Container(
              width: context.width(88),
              height: context.height(90),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  context.width(10),
                ),
                image: const DecorationImage(
                  image: AssetImage("assets/images/img_music_list.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // width spacer
            WhiteSpace.space(context: context, width: 10),
            //music title and singer
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // music title
                SizedBox(
                  width: context.width(290),
                  child: Text(
                    songName.length > 70 ? songName.substring(0, 70) : songName,
                    style: GoogleFonts.nunito(
                      color: AppColors.white,
                      fontSize: context.width(15),
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
                // height space
                WhiteSpace.space(context: context, height: 5),
                // singer name
                Text(
                  singer,
                  style: GoogleFonts.nunito(
                    color: AppColors.whiteSmokeGrey,
                    fontSize: context.width(12),
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
