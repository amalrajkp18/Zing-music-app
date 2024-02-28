import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/core/utils/white_space.dart';

class MusicTileWidget extends StatelessWidget {
  const MusicTileWidget({
    super.key,
  });

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
                Text(
                  "Take care of you",
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
                  "Admina Thembi",
                  style: GoogleFonts.nunito(
                    color: AppColors.whiteSmokeGrey,
                    fontSize: context.width(13),
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
            // spacer
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border_outlined,
                color: AppColors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
