import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/core/utils/white_space.dart';
import 'package:music_app/presentation/providers/audio_player_provider/audio_player_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/songs_provider.dart';
import 'package:music_app/presentation/widgets/music_button_widget.dart';

import 'widget/music_image_widget.dart';
import 'widget/music_playerapp_bar_widget.dart';
import 'widget/music_progress_widget.dart';

class MusicPlayerPage extends ConsumerWidget {
  const MusicPlayerPage({
    super.key,
  });
  static const String routeName = "/musicplayerpage";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: musicPlayerAppBarWidget(
        context: context,
        title: ref
                .watch(songsProvider)
                .value?[ref.watch(currentIndexProvider) ?? 0]
                .title ??
            "",
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
            const MusicProgressWidget(),
            // height space
            WhiteSpace.space(context: context, height: 70),
            // player controllers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // shuffle button
                MusicButtonWidget(
                  icon: Icons.shuffle,
                  iconColor: ref.watch(shuffleStateProvider)
                      ? AppColors.playPauseCircle
                      : AppColors.white,
                  onPressed: () {
                    ref.read(shuffleStateProvider.notifier).state =
                        !ref.read(shuffleStateProvider);
                    ref.read(audioPlayerProvider).setShuffleModeEnabled(
                          ref.watch(shuffleStateProvider),
                        );
                  },
                ),
                //skip previous button
                MusicButtonWidget(
                  icon: Icons.skip_previous_outlined,
                  onPressed: () async {
                    await ref.read(audioPlayerProvider).seekToPrevious();
                    ref.read(currentIndexProvider.notifier).state =
                        ref.read(audioPlayerProvider).currentIndex;
                  },
                  size: 60,
                ),
                // play pause button
                InkWell(
                  onTap: () async {
                    ref.watch(playStateProvider)
                        ? ref.read(playStateProvider.notifier).state = false
                        : ref.read(playStateProvider.notifier).state = true;
                    // pause or play
                    ref.watch(audioPlayerProvider).playing
                        ? ref.read(audioPlayerProvider).pause()
                        : ref.read(audioPlayerProvider).play();
                  },
                  borderRadius: BorderRadius.circular(context.width(80)),
                  child: CircleAvatar(
                    radius: context.width(50),
                    backgroundColor: AppColors.playPauseCircle,
                    child: ref.watch(playStateProvider)
                        ? Icon(
                            Icons.play_arrow,
                            color: AppColors.white,
                            size: context.width(60),
                          )
                        : Icon(
                            Icons.pause,
                            color: AppColors.white,
                            size: context.width(60),
                          ),
                  ),
                ),
                //skip next button
                MusicButtonWidget(
                  icon: Icons.skip_next_outlined,
                  onPressed: () async {
                    await ref.read(audioPlayerProvider).seekToNext();
                    ref.read(currentIndexProvider.notifier).state =
                        ref.read(audioPlayerProvider).currentIndex;
                  },
                  size: 60,
                ),
                // repeat button
                MusicButtonWidget(
                  icon: ref.watch(repeatStateProvider)
                      ? Icons.repeat_one
                      : Icons.repeat,
                  iconColor: ref.watch(repeatStateProvider)
                      ? AppColors.playPauseCircle
                      : AppColors.white,
                  onPressed: () {
                    ref.read(repeatStateProvider.notifier).state =
                        !ref.read(repeatStateProvider);
                    ref.watch(repeatStateProvider)
                        ? ref
                            .read(audioPlayerProvider)
                            .setLoopMode(LoopMode.one)
                        : ref
                            .read(audioPlayerProvider)
                            .setLoopMode(LoopMode.off);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
