import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zing/core/colors/app_colors.dart';
import 'package:zing/core/utils/app_responsive_units.dart';
import 'package:zing/core/utils/white_space.dart';
import 'package:zing/presentation/providers/songs_provider/current_songs_provider.dart';
import 'package:zing/presentation/providers/songs_provider/songs_provider.dart';

import 'widget/music_image_widget.dart';
import 'widget/music_player_app_bar_widget.dart';
import 'widget/music_progress_widget.dart';
import 'widget/play_controller_button_widget.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({
    super.key,
  });
  static const String routeName = "/musicplayerpage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: musicPlayerAppBarWidget(
        context: context,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.width(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // height space
            WhiteSpace.space(context: context, height: 20),
            //music image
            const MusicImageWidget(),
            // music title
            Consumer(
              builder: (context, ref, child) => Column(
                children: [
                  // song title
                  Text(
                    ref
                            .watch(currentSongsProvider)?[
                                ref.watch(currentIndexProvider) ?? 0]
                            .title ??
                        "",
                    style: GoogleFonts.nunito(
                      color: AppColors.white,
                      fontSize: context.width(18),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // artist name
                  Text(
                    ref
                            .watch(currentSongsProvider)?[
                                ref.watch(currentIndexProvider) ?? 0]
                            .artist ??
                        "",
                    style: GoogleFonts.nunito(
                      color: AppColors.grey,
                      fontSize: context.width(14),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // music progress bar
            const MusicProgressWidget(),
            // player controllers
            const PlayControllerButtonsWidget(),
            // height space
            WhiteSpace.space(context: context, height: 60),
          ],
        ),
      ),
    );
  }
}
