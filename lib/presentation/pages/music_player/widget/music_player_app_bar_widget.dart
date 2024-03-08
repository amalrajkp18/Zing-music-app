import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/domain/entities/liked_song_entity/liked_song_entity.dart';
import 'package:music_app/domain/usecases/liked_song_uses_case/liked_song_box_use_case.dart';
import 'package:music_app/presentation/providers/liked_song_provider/liked_check_provider.dart';
import 'package:music_app/presentation/providers/liked_song_provider/liked_song_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/current_songs_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/songs_provider.dart';
import 'package:music_app/presentation/widgets/music_button_widget.dart';

AppBar musicPlayerAppBarWidget({required BuildContext context}) {
  return AppBar(
    // back button
    leading: MusicButtonWidget(
      icon: Icons.arrow_back_ios,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: const Text("Now Playing"),
    centerTitle: true,
    actions: [
      // fav button
      Consumer(
        builder: (context, ref, _) => MusicButtonWidget(
          icon: ref.watch(likedCheckProvider).isLiked
              ? Icons.favorite
              : Icons.favorite_border_sharp,
          iconColor: ref.watch(likedCheckProvider).isLiked
              ? Colors.red
              : AppColors.white,
          onPressed: () {
            // Liked song add  or remove
            if (ref.read(likedCheckProvider).isLiked) {
              LikedSongBoxUseCase.remove(ref.read(likedCheckProvider).id!);
            } else {
              LikedSongBoxUseCase.add(
                LikedSongEntity(
                    data: ref
                        .read(currentSongsProvider)![
                            ref.read(currentIndexProvider)!]
                        .data),
              );
            }
            ref.invalidate(likedSongsProvider);
          },
        ),
      )
    ],
  );
}
