import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/core/utils/white_space.dart';
import 'package:music_app/domain/usecases/audio_source_usecase/set_audio_source_usecase.dart';
import 'package:music_app/presentation/providers/audio_player_provider/audio_player_provider.dart';
import 'package:music_app/presentation/providers/liked_song_provider/liked_song_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/current_songs_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/songs_provider.dart';
import 'package:music_app/presentation/widgets/music_tile_widget.dart';
import 'package:music_app/presentation/widgets/shimmers/liked_list_shimmer.dart';

class LikedSongsPage extends ConsumerWidget {
  const LikedSongsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        //  page title
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
                        "liked songs not found",
                        style: GoogleFonts.nunito(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) => InkWell(
                  onTap: () async {
                    // add songs list
                    ref.read(currentSongsProvider.notifier).addSongs(data);
                    // play list
                    final ConcatenatingAudioSource playlist =
                        SetAudioSourceUseCase.set(data);

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
                    songName: data[index].title,
                    singer: data[index].artist ?? '',
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
            loading: () => const LikedListShimmer(),
          ),
    );
  }
}
