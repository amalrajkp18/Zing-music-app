import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/presentation/pages/library/liked_songs_page.dart';
import 'package:music_app/presentation/pages/library/widget/library_tile_widget.dart';
import 'package:music_app/presentation/providers/liked_song_provider/liked_song_provider.dart';
import 'package:music_app/presentation/widgets/music_button_widget.dart';

import 'widget/play_list_title_control_widget.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController playListEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        //  page title
        title: const Text("Library"),
        actions: [
          // playlist create button
          MusicButtonWidget(
            icon: Icons.add,
            onPressed: () {
              // add play list
              playlistTtileControlWidget(
                context: context,
                textEditingController: playListEditingController,
                onPressed: () {
                  // TODO
                },
              );
            },
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          // liked tile
          LibraryTileWidget(
            isLiked: true,
            title: "Liked Songs",
            songCount: ref.watch(likedSongsProvider).value?.length ?? 0,
            onTap: () {
              // page navigator
              Navigator.pushNamed(context, LikedSongsPage.routeName);
            },
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => LibraryTileWidget(
              title: "title",
              songCount: 5,
              onTap: () {
                // TODO
              },
              trailing: PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == '/delete') {
                    print("object");
                  } else if (value == '/edit') {
                    playListEditingController.text = "";
                    playlistTtileControlWidget(
                      context: context,
                      textEditingController: playListEditingController,
                      isEdit: true,
                      onPressed: () {
                        // TODO
                      },
                    );
                  }
                },
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      value: '/delete',
                      child: Text(
                        "Delete",
                        style: Theme.of(context).popupMenuTheme.textStyle,
                      ),
                    ),
                    PopupMenuItem(
                      value: '/edit',
                      child: Text(
                        "Edit",
                        style: Theme.of(context).popupMenuTheme.textStyle,
                      ),
                    ),
                  ];
                },
              ),
            ),
            itemCount: 10,
          )
        ],
      ),
    );
  }
}
