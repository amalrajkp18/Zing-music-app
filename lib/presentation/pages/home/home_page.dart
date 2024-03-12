import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zing/core/colors/app_colors.dart';
import 'package:zing/core/utils/app_responsive_units.dart';
import 'package:zing/domain/usecases/audio_source_usecase/set_audio_source_usecase.dart';
import 'package:zing/presentation/providers/audio_player_provider/audio_player_provider.dart';
import 'package:zing/presentation/providers/songs_provider/current_songs_provider.dart';
import 'package:zing/presentation/providers/songs_provider/songs_provider.dart';
import 'package:zing/presentation/widgets/music_tile_widget.dart';
import 'package:zing/presentation/widgets/shimmers/music_list_shimmer.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(songsProvider);
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // app title app bar
              SliverAppBar(
                backgroundColor: AppColors.scaffoldBg,
                toolbarHeight: context.height(80),
                title: Text(
                  "Zing",
                  style: Theme.of(context).primaryTextTheme.titleLarge,
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
                                  "assets/images/img_data_is_empty.png",
                                  width: context.width(300),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      // play list
                      final ConcatenatingAudioSource playlist =
                          SetAudioSourceUseCase.set(data);

                      return SliverList.builder(
                        // music list view
                        itemBuilder: (context, index) => InkWell(
                          onTap: () async {
                            // add songs list
                            ref
                                .read(currentSongsProvider.notifier)
                                .addSongs(data);

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
                          Text(
                            "error ocuured${error.toString()}",
                            style: Theme.of(context).primaryTextTheme.bodySmall,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ref.invalidate(songsProvider);
                            },
                            child: Text(
                              "Reload",
                              style:
                                  Theme.of(context).primaryTextTheme.bodySmall,
                            ),
                          )
                        ],
                      ),
                    ),
                    loading: () => SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => const MusicListShimmer(),
                          childCount: 8),
                    ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
