import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/presentation/providers/audio_player_provider/audio_player_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/songs_provider.dart';

class MusicProgressWidget extends ConsumerWidget {
  const MusicProgressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: ref.read(audioPlayerProvider).positionStream,
      builder: (context, snapshot) {
        ///read current index
        ref.invalidate(currentIndexProvider);

        return ProgressBar(
          onSeek: (value) async {
            await ref.read(audioPlayerProvider).seek(value);
          },
          progressBarColor: AppColors.playProgress,
          baseBarColor: AppColors.white,
          bufferedBarColor: AppColors.grey,
          thumbColor: AppColors.playProgress,
          barHeight: context.height(8),
          thumbRadius: context.width(8),
          progress: snapshot.data ?? Duration.zero,
          total: ref.watch(audioPlayerProvider).duration ?? Duration.zero,
          timeLabelTextStyle: GoogleFonts.nunito(
            color: AppColors.white,
          ),
        );
      },
    );
  }
}
