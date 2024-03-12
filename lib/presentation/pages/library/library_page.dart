import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/domain/entities/play_list_entity/play_list_entity.dart';
import 'package:music_app/domain/usecases/playlist_use_case/play_list_box_use_case.dart';
import 'package:music_app/presentation/pages/library/liked_songs_page/liked_songs_page.dart';
import 'package:music_app/presentation/widgets/library_tile_widget.dart';
import 'package:music_app/presentation/pages/library/widget/play_list_builder_widget.dart';
import 'package:music_app/presentation/providers/liked_song_provider/liked_song_provider.dart';
import 'package:music_app/presentation/providers/play_list_provider/play_list_provider.dart';
import 'package:music_app/presentation/widgets/music_button_widget.dart';

import '../../widgets/play_list_title_control_widget.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController playListEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        //  page title
        title: const Text("Library"),
        actions: [
          // playlist create button
          Consumer(
            builder: (context, ref, _) => MusicButtonWidget(
              icon: Icons.add,
              onPressed: () {
                // create playlist
                playlistTtileControlWidget(
                  context: context,
                  textEditingController: playListEditingController,
                  onPressed: () {
                    // add play list name
                    if (playListEditingController.text.isNotEmpty) {
                      PlayListBoxUseCase.add(
                        PlayListEntity(
                            playListName: playListEditingController.text),
                      );
                      ref.invalidate(playListProvider);
                      Navigator.pop(context);
                      playListEditingController.clear();
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          // liked songs
          Consumer(
            builder: (context, ref, _) => LibraryTileWidget(
              isLiked: true,
              title: "Liked Songs",
              songCount:
                  "${ref.watch(likedSongsProvider).value?.length ?? 0} songs for you",
              onTap: () {
                // page navigator
                Navigator.pushNamed(context, LikedSongsPage.routeName);
              },
            ),
          ),
          // play list
          const PlayListBuilderWidget()
        ],
      ),
    );
  }
}
