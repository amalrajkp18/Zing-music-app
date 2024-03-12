import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zing/core/utils/app_responsive_units.dart';
import 'package:zing/domain/usecases/audio_source_usecase/set_audio_source_usecase.dart';
import 'package:zing/presentation/providers/audio_player_provider/audio_player_provider.dart';
import 'package:zing/presentation/providers/search_provider/search_provider.dart';
import 'package:zing/presentation/providers/songs_provider/current_songs_provider.dart';
import 'package:zing/presentation/providers/songs_provider/songs_provider.dart';
import 'package:zing/presentation/widgets/music_tile_widget.dart';

import 'widget/search_bar_widget.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        //  page title
        title: const Text(
          "Search",
        ),
      ),
      body: Column(
        children: [
          const SearchBarWidget(),
          (ref.watch(searchProvider) != null &&
                  ref.watch(searchProvider)!.isEmpty)
              ? const SizedBox.shrink()
              : ref.watch(searchProvider) == null
                  ? Padding(
                      padding: EdgeInsets.only(top: context.height(80)),
                      child: Image.asset(
                        "assets/images/img_search_not_found.png",
                        width: context.width(200),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              // add songs list
                              ref
                                  .read(currentSongsProvider.notifier)
                                  .addSongs(ref.read(searchProvider));

                              // playlist
                              final ConcatenatingAudioSource playlist =
                                  SetAudioSourceUseCase.set(
                                ref.watch(searchProvider)!,
                              );

                              ref.invalidate(playStateProvider);

                              // read song path
                              await ref
                                  .read(audioPlayerProvider)
                                  .setAudioSource(
                                    playlist,
                                    initialIndex: index,
                                  );

                              // play song for click
                              await ref.read(audioPlayerProvider).play();

                              // notify index chaged
                              ref.invalidate(currentIndexProvider);
                            },
                            child: MusicTileWidget(
                              songName:
                                  ref.watch(searchProvider)?[index].title ?? "",
                              singer:
                                  ref.watch(searchProvider)?[index].artist ??
                                      "",
                            ),
                          );
                        },
                        itemCount: ref.watch(searchProvider)?.length,
                      ),
                    )
        ],
      ),
    );
  }
}
