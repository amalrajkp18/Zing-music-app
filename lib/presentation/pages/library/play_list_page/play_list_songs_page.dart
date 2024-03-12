import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/domain/entities/play_list_entity/play_list_entity.dart';
import 'package:music_app/domain/usecases/audio_source_usecase/set_audio_source_usecase.dart';
import 'package:music_app/domain/usecases/playlist_use_case/play_list_box_use_case.dart';
import 'package:music_app/presentation/providers/audio_player_provider/audio_player_provider.dart';
import 'package:music_app/presentation/providers/play_list_provider/play_list_provider.dart';
import 'package:music_app/presentation/providers/play_list_provider/play_list_songs_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/current_songs_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/songs_provider.dart';
import 'package:music_app/presentation/widgets/music_button_widget.dart';
import 'package:music_app/presentation/widgets/music_tile_widget.dart';
import 'package:music_app/presentation/widgets/shimmers/music_list_shimmer.dart';

class PlayListSongPage extends StatelessWidget {
  const PlayListSongPage({
    super.key,
    required this.title,
    required this.songList,
    required this.id,
  });

  final String title;
  final List<String> songList;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MusicButtonWidget(
          icon: Icons.arrow_back_ios,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("$title play list"),
      ),
      body: songList.isEmpty
          ? Center(
              child: Image.asset(
                "assets/images/img_data_is_empty.png",
                width: context.width(300),
              ),
            )
          : Consumer(
              builder: (context, ref, _) => ref
                  .watch(playListSongsProvider(songData: songList))
                  .when(
                    data: (data) {
                      // play list
                      final ConcatenatingAudioSource playlist =
                          SetAudioSourceUseCase.set(data);

                      return ListView.builder(
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
                            textWidgetWidth: 240,
                            textCount: 60,
                            isLibary: true,
                            songName: data[index].title,
                            singer: data[index].artist ?? "",
                            librayPressed: () {
                              // remove song from playlist
                              songList.remove(data[index].data);
                              log(songList.toString());
                              PlayListBoxUseCase.add(
                                PlayListEntity(
                                    id: id,
                                    playListName: title,
                                    songList: songList),
                              );
                              ref.invalidate(playListSongsProvider);
                              ref.invalidate(playListProvider);
                            },
                          ),
                        ),
                        itemCount: data.length,
                      );
                    },
                    error: (error, stackTrace) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "error ocuured${error.toString()}",
                            style: Theme.of(context).primaryTextTheme.bodySmall,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ref.invalidate(playListSongsProvider);
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
                    loading: () => ListView.builder(
                      itemBuilder: (context, index) => const MusicListShimmer(),
                      itemCount: 12,
                    ),
                  ),
            ),
    );
  }
}
