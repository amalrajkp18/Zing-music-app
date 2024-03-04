import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/core/utils/white_space.dart';
import 'package:music_app/presentation/providers/audio_player_provider/audio_player_provider.dart';
import 'package:music_app/presentation/widgets/music_button_widget.dart';

import 'widget/music_image_widget.dart';
import 'widget/music_playerapp_bar_widget.dart';

class MusicPlayerPage extends ConsumerWidget {
  const MusicPlayerPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: musicPlayerAppBarWidget(
        context: context,
        title: "songList[index].title.substring(0, 20)",
      ),
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
            // music progress bar
            ProgressBar(
              progressBarColor: AppColors.playProgress,
              baseBarColor: AppColors.white,
              bufferedBarColor: AppColors.grey,
              thumbColor: AppColors.playProgress,
              barHeight: context.height(8),
              thumbRadius: context.width(8),
              progress: Duration.zero,
              total: ref.watch(audioPlayerProvider).duration ?? Duration.zero,
              timeLabelTextStyle: GoogleFonts.nunito(
                color: AppColors.white,
              ),
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
                InkWell(
                  onTap: () async {
                    // pause or play
                    ref.watch(audioPlayerProvider).playing
                        ? await ref.read(audioPlayerProvider).pause()
                        : await ref.read(audioPlayerProvider).play();
                  },
                  child: CircleAvatar(
                    radius: context.width(50),
                    backgroundColor: AppColors.playPauseCircle,
                    child: ref.watch(audioPlayerProvider).playing
                        ? Icon(
                            Icons.pause,
                            color: AppColors.white,
                            size: context.width(60),
                          )
                        : Icon(
                            Icons.play_arrow,
                            color: AppColors.white,
                            size: context.width(60),
                          ),
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
