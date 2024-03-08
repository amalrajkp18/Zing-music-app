import 'package:flutter/material.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/core/utils/white_space.dart';
import 'package:shimmer/shimmer.dart';

class MusicListShimmer extends StatelessWidget {
  const MusicListShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey.withOpacity(0.1),
      highlightColor: AppColors.grey.withOpacity(0.6),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: context.width(5)),
        width: context.width(350),
        height: context.height(105),
        child: Row(
          children: [
            // music thumbnail
            CircleAvatar(
              radius: context.width(35),
              backgroundColor: AppColors.grey,
            ),
            // width spacer
            WhiteSpace.space(context: context, width: 10),
            //music title and singer
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // music title
                Container(
                  width: context.width(180),
                  height: context.height(20),
                  color: AppColors.grey,
                ),
                // height space
                WhiteSpace.space(context: context, height: 5),
                // singer name
                Container(
                  width: context.width(120),
                  height: context.height(12),
                  color: AppColors.grey,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
