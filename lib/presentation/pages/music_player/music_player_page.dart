import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/core/utils/white_space.dart';
import 'package:music_app/presentation/widgets/music_button_widget.dart';

import 'widget/music_image_widget.dart';
import 'widget/music_playerapp_bar_widget.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({super.key});
  static const String routeName = '/musicplayerpage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: musicPlayerAppBarWidget(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.width(30),
        ),
        child: Column(
          children: [
            // height space
            WhiteSpace.space(context: context, height: 80),
            //music image
            const MusicImageWidget(),
            // height space
            WhiteSpace.space(context: context, height: 80),
            // music time indicator
            LinearProgressIndicator(
              backgroundColor: AppColors.white,
              color: AppColors.playProgress,
              borderRadius: BorderRadius.circular(context.width(200)),
              minHeight: context.width(8),
              value: 0.3,
            ),
            // height space
            WhiteSpace.space(context: context, height: 15),
            // time duration music
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // time start
                Text(
                  "1:25",
                  style: GoogleFonts.nunito(
                    color: AppColors.white,
                    fontSize: context.width(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // total time
                Text(
                  "4:25",
                  style: GoogleFonts.nunito(
                    color: AppColors.white,
                    fontSize: context.width(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            // height space
            WhiteSpace.space(context: context, height: 70),
            // player controllers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // shuffle button
                MusicButtonWidget(
                  icon: Icons.shuffle,
                  onPressed: () {},
                ),
                //skip previous button
                MusicButtonWidget(
                  icon: Icons.skip_previous_outlined,
                  onPressed: () {},
                  size: 60,
                ),
                // play pause button
                CircleAvatar(
                  radius: context.width(50),
                  backgroundColor: AppColors.playPauseCircle,
                  child: Icon(
                    Icons.pause,
                    color: AppColors.white,
                    size: context.width(60),
                  ),
                ),
                //skip next button
                MusicButtonWidget(
                  icon: Icons.skip_next_outlined,
                  onPressed: () {},
                  size: 60,
                ),
                // repeat button
                MusicButtonWidget(
                  icon: Icons.repeat,
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
