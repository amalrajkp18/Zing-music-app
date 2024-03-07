import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/presentation/providers/liked_song_provider/liked_song_provider.dart';
import 'package:music_app/presentation/widgets/music_tile_widget.dart';

class LikedSongsPage extends ConsumerWidget {
  const LikedSongsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        //  page title
        title: Text(
          "Liked Songs",
          style: GoogleFonts.nunito(
            color: AppColors.white,
            fontSize: context.width(24),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ref.watch(likedSongProvider).isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) => MusicTileWidget(
                  songName: ref.watch(likedSongProvider)[index].title,
                  singer: ref.watch(likedSongProvider)[index].artist ?? ""),
            )
          : const FlutterLogo(),
    );
  }
}
