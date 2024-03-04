import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/presentation/providers/audio_player_provider/audio_player_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/songs_provider.dart';
import 'package:music_app/presentation/widgets/music_button_widget.dart';

class MusicPlayerBar extends ConsumerWidget {
  const MusicPlayerBar({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: context.width(420),
            height: context.width(80),
            padding: EdgeInsets.symmetric(
              horizontal: context.width(10),
              vertical: context.height(10),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.black.withOpacity(0.6),
                  AppColors.black.withOpacity(0.8)
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
              borderRadius: BorderRadius.circular(context.width(10)),
              border: Border.all(
                width: 1.5,
                color: AppColors.grey.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: context.width(70),
                  height: context.height(70),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(context.width(5)),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/img_music_list.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // song name
                Padding(
                  padding: EdgeInsets.only(left: context.width(12)),
                  child: Text(
                    ref
                            .watch(songsProvider)
                            .value?[ref.watch(currentIndexProvider) ?? 0]
                            .title
                            .substring(0, 15) ??
                        "",
                    style: GoogleFonts.nunito(
                      color: AppColors.white,
                      fontSize: context.width(20),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // spacer
                const Spacer(),
                // pause or play button
                MusicButtonWidget(
                  size: 38,
                  icon: ref.watch(playStateProvider)
                      ? Icons.play_arrow
                      : Icons.pause,
                  onPressed: () {
                    ref.watch(playStateProvider)
                        ? ref.read(playStateProvider.notifier).state = false
                        : ref.read(playStateProvider.notifier).state = true;
                    ref.read(audioPlayerProvider).playing
                        ? ref.read(audioPlayerProvider).pause()
                        : ref.read(audioPlayerProvider).play();
                  },
                ),
                MusicButtonWidget(
                  size: 38,
                  icon: Icons.skip_next,
                  onPressed: () async {
                    await ref.read(audioPlayerProvider).seekToNext();
                    ref.read(currentIndexProvider.notifier).state =
                        ref.read(audioPlayerProvider).currentIndex;
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
