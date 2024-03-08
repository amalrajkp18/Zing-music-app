import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/presentation/pages/library/liked_songs_page.dart';
import 'package:music_app/presentation/pages/library/widget/library_tile_widget.dart';
import 'package:music_app/presentation/providers/liked_song_provider/liked_song_provider.dart';
import 'package:music_app/presentation/widgets/music_button_widget.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        //  page title
        title: const Text("Library"),
        actions: [
          // playlist create button
          MusicButtonWidget(
            icon: Icons.add,
            onPressed: () {},
          )
        ],
      ),
      body: Column(
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
          )
        ],
      ),
    );
  }
}
