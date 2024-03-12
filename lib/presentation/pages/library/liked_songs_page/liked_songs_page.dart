import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/core/utils/white_space.dart';
import 'package:music_app/domain/entities/liked_song_entity/liked_song_entity.dart';
import 'package:music_app/domain/usecases/audio_source_usecase/set_audio_source_usecase.dart';
import 'package:music_app/domain/usecases/liked_song_uses_case/liked_song_box_use_case.dart';
import 'package:music_app/presentation/providers/audio_player_provider/audio_player_provider.dart';
import 'package:music_app/presentation/providers/liked_song_provider/liked_song_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/current_songs_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/songs_provider.dart';
import 'package:music_app/presentation/widgets/music_button_widget.dart';
import 'package:music_app/presentation/widgets/music_tile_widget.dart';
import 'package:music_app/presentation/widgets/shimmers/music_list_shimmer.dart';

class LikedSongsPage extends ConsumerWidget {
  const LikedSongsPage({super.key});

  static const String routeName = '/Likedsongs';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: MusicButtonWidget(
          icon: Icons.arrow_back_ios,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Liked Songs"),
      ),
      body: ref.watch(likedSongsProvider).when(
            data: (data) {
              if (data.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // image is not data
                      Image.asset(
                        "assets/images/img_favorite_empty.png",
                        width: context.width(200),
                      ),
                      // height space
                      WhiteSpace.space(context: context, height: 20),
                      // text is not data
                      Text(
                        "There is no Liked songs",
                        style: GoogleFonts.nunito(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }
              // play list
              final ConcatenatingAudioSource playlist =
                  SetAudioSourceUseCase.set(data);
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => InkWell(
                  onTap: () async {
                    // add songs list
                    ref.read(currentSongsProvider.notifier).addSongs(data);

                    ref.invalidate(playStateProvider);

                    // notify index chaged
                    ref.invalidate(currentIndexProvider);

                    // read song path
                    await ref.read(audioPlayerProvider).setAudioSource(
                          playlist,
                          initialIndex: index,
                        );

                    // play song for click
                    await ref.read(audioPlayerProvider).play();
                  },
                  child: MusicTileWidget(
                    isLibary: true,
                    isLiked: true,
                    textWidgetWidth: 230,
                    textCount: 45,
                    songName: data[index].title,
                    singer: data[index].artist ?? '',
                    librayPressed: () {
                      // Liked song  remove
                      LikedSongEntity? songEntity =
                          LikedSongBoxUseCase.checkIsLiked(data[index]);
                      if (songEntity != null) {
                        LikedSongBoxUseCase.remove(songEntity.id);
                      }
                      ref.invalidate(likedSongsProvider);
                    },
                  ),
                ),
                itemCount: data.length,
              );
            },
            error: (error, stackTrace) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // error text
                Text(
                  "error ${error.toString()}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                // height space
                WhiteSpace.space(context: context, height: 20),
                // button invalidate provider
                ElevatedButton(
                  onPressed: () async {
                    ref.invalidate(likedSongsProvider);
                  },
                  child: Text(
                    "Reload",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
              ],
            ),
            loading: () => ListView.builder(
              itemBuilder: (context, index) => const MusicListShimmer(),
              itemCount: 8,
            ),
          ),
    );
  }
}
