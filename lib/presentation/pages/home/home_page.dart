import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/presentation/providers/audio_player_provider/audio_player_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/songs_provider.dart';
import 'package:music_app/presentation/widgets/music_tile_widget.dart';
import 'package:music_app/presentation/widgets/shimmers/music_list_shimmer.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            // app title app bar
            SliverAppBar(
              backgroundColor: AppColors.scaffoldBg,
              toolbarHeight: context.height(80),
              title: Text(
                "Zing",
                style: GoogleFonts.pacifico(
                  color: AppColors.white,
                  fontSize: context.width(40),
                ),
              ),
              floating: true,
            ),
            // list view
            ref.watch(songsProvider).when(
                  data: (data) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          // set audio source
                          final List<AudioSource> audioSources = data
                              .map(
                                (source) => AudioSource.file(source.data),
                              )
                              .toList();
                          // create playlist
                          final playlist =
                              ConcatenatingAudioSource(children: audioSources);
                          // music list view
                          return InkWell(
                            onTap: () {
                              //player visibler
                              ref.read(playBarProvider.notifier).state = true;
                              ref.invalidate(playStateProvider);
                              ref.invalidate(currentIndexProvider);
                              // read song path
                              ref.read(audioPlayerProvider).setAudioSource(
                                    playlist,
                                    initialIndex: index,
                                  );

                              // play song for click
                              ref.read(audioPlayerProvider).play();
                            },
                            child: MusicTileWidget(
                              songName: data[index].title.substring(0, 20),
                              singer: data[index].artist ?? '',
                            ),
                          );
                        },
                        childCount: data.length,
                      ),
                    );
                  },
                  error: (error, stackTrace) => SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Text("error ocuured${error.toString()}"),
                        IconButton(
                          onPressed: () {
                            ref.invalidate(songsProvider);
                          },
                          icon: const Icon(
                            Icons.repeat_outlined,
                          ),
                        )
                      ],
                    ),
                  ),
                  loading: () => const MusicListShimmer(),
                )
          ],
        ),
      ),
    );
  }
}
