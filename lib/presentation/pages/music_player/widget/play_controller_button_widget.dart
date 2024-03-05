import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/presentation/providers/audio_player_provider/audio_player_provider.dart';
import 'package:music_app/presentation/widgets/music_button_widget.dart';

class PlayControllerButtonsWidget extends ConsumerWidget {
  const PlayControllerButtonsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
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
                ? await ref.read(audioPlayerProvider).pause()
                : await ref.read(audioPlayerProvider).play();
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
          },
          size: 60,
        ),
        // repeat button
        MusicButtonWidget(
          icon:
              ref.watch(repeatStateProvider) ? Icons.repeat_one : Icons.repeat,
          iconColor: ref.watch(repeatStateProvider)
              ? AppColors.playPauseCircle
              : AppColors.white,
          onPressed: () async {
            ref.read(repeatStateProvider.notifier).state =
                !ref.read(repeatStateProvider);
            ref.watch(repeatStateProvider)
                ? await ref.read(audioPlayerProvider).setLoopMode(LoopMode.one)
                : await ref.read(audioPlayerProvider).setLoopMode(LoopMode.off);
          },
        ),
      ],
    );
  }
}
