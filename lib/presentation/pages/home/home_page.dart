import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/domain/usecases/audio_source_usecase/set_audio_source_usecase.dart';
import 'package:music_app/presentation/providers/audio_player_provider/audio_player_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/current_songs_provider.dart';
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
                    if (data.isEmpty) {
                      // data empty widget
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/images/img_data_is-empty.png",
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    return SliverList.builder(
                      // music list view
                      itemBuilder: (context, index) => InkWell(
                        onTap: () async {
                          // add songs list
                          ref
                              .read(currentSongsProvider.notifier)
                              .addSongs(data);
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
