import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/domain/entities/liked_song_entity/liked_song_entity.dart';
import 'package:music_app/domain/usecases/liked_song_uses_case/liked_song_box_use_case.dart';
import 'package:music_app/presentation/providers/audio_player_provider/audio_player_provider.dart';
import 'package:music_app/presentation/providers/liked_song_provider/liked_check_provider.dart';
import 'package:music_app/presentation/providers/liked_song_provider/liked_song_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/current_songs_provider.dart';
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
    //listen if change song
    ref.watch(audioPlayerProvider).positionStream.listen(
      (_) {
        ref.invalidate(currentIndexProvider);
        ref.invalidate(playStateProvider);
        // check is liked or not
        ref.read(likedCheckProvider.notifier).isLiked(
            ref.watch(currentSongsProvider)![ref.watch(currentIndexProvider)!]);
      },
    );

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
              color: AppColors.scaffoldBg,
              borderRadius: BorderRadius.circular(context.width(10)),
              border: Border.all(
                width: 1.5,
                color: AppColors.grey.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                // image thubnail
                CircleAvatar(
                  radius: context.width(30),
                  backgroundImage:
                      const AssetImage("assets/images/img_music_list.png"),
                ),
                // song name
                Padding(
                  padding: EdgeInsets.only(left: context.width(12)),
                  child: SizedBox(
                    width: context.width(160),
                    child: Text(
                      ref
                              .watch(currentSongsProvider)?[
                                  ref.watch(currentIndexProvider) ?? 0]
                              .title ??
                          "",
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // spacer
                const Spacer(),
                // favorite button
                MusicButtonWidget(
                  icon: ref.watch(likedCheckProvider).isLiked
                      ? Icons.favorite
                      : Icons.favorite_border,
                  iconColor: ref.watch(likedCheckProvider).isLiked
                      ? Colors.red
                      : AppColors.white,
                  onPressed: () {
                    // Liked song add  or remove
                    if (ref.read(likedCheckProvider).isLiked) {
                      LikedSongBoxUseCase.remove(
                          ref.read(likedCheckProvider).id!);
                    } else {
                      LikedSongBoxUseCase.add(
                        LikedSongEntity(
                            data: ref
                                .read(currentSongsProvider)![
                                    ref.read(currentIndexProvider)!]
                                .data),
                      );
                    }
                    ref.invalidate(likedSongsProvider);
                  },
                ),
                // pause or play button
                MusicButtonWidget(
                  size: 38,
                  icon: ref.watch(playStateProvider)
                      ? Icons.pause
                      : Icons.play_arrow,
                  onPressed: () async {
                    ref.read(audioPlayerProvider).playing
                        ? await ref.read(audioPlayerProvider).pause()
                        : await ref.read(audioPlayerProvider).play();
                  },
                ),
                MusicButtonWidget(
                  size: 38,
                  icon: Icons.skip_next,
                  onPressed: () async {
                    await ref.read(audioPlayerProvider).seekToNext();
                    if (!ref.read(playStateProvider)) {
                      await ref.read(audioPlayerProvider).play();
                    }
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
