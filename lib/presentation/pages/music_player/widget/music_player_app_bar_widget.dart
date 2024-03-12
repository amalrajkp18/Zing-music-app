import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/domain/entities/liked_song_entity/liked_song_entity.dart';
import 'package:music_app/domain/entities/play_list_entity/play_list_entity.dart';
import 'package:music_app/domain/usecases/liked_song_uses_case/liked_song_box_use_case.dart';
import 'package:music_app/domain/usecases/playlist_use_case/play_list_box_use_case.dart';
import 'package:music_app/presentation/providers/liked_song_provider/liked_check_provider.dart';
import 'package:music_app/presentation/providers/liked_song_provider/liked_song_provider.dart';
import 'package:music_app/presentation/providers/play_list_provider/play_list_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/current_songs_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/songs_provider.dart';
import 'package:music_app/presentation/widgets/library_tile_widget.dart';
import 'package:music_app/presentation/widgets/music_button_widget.dart';
import 'package:music_app/presentation/widgets/play_list_title_control_widget.dart';

AppBar musicPlayerAppBarWidget({required BuildContext context}) {
  TextEditingController playListEditingController = TextEditingController();

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
      ),
      Consumer(
        builder: (context, ref, child) => PopupMenuButton(
          onSelected: (value) {
            if (value == '/Createplaylist') {
              // create playlist
              playlistTtileControlWidget(
                context: context,
                textEditingController: playListEditingController,
                onPressed: () {
                  // add new play list
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
            }
            if (value == '/Addsongplaylist') {
              // add song play list
              addSongsPlayListWidget(context, ref);
            }
          },
          icon: const Icon(
            Icons.more_vert,
            color: AppColors.white,
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: '/Createplaylist',
              child: Text(
                "Create Play list",
                style: Theme.of(context).popupMenuTheme.textStyle,
              ),
            ),
            PopupMenuItem(
              value: '/Addsongplaylist',
              child: Text(
                "Add Song Playlist",
                style: Theme.of(context).popupMenuTheme.textStyle,
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Future<dynamic> addSongsPlayListWidget(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      color: AppColors.scaffoldBg,
      width: context.width(430),
      child: ListView.builder(
        itemBuilder: (context, index) {
          PlayListEntity playListEntity = ref.watch(playListProvider)[index];
          return LibraryTileWidget(
            libaryBoxSize: 60,
            title: playListEntity.playListName,
            songCount: "${playListEntity.songList.length} songs playlist",
            onTap: () {
              // check songs in playlist already
              if (PlayListBoxUseCase.isAlreadyExistSong(
                id: playListEntity.id,
                data: ref
                    .watch(
                        currentSongsProvider)![ref.watch(currentIndexProvider)!]
                    .data,
              )) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Song already exist",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                );
              } else {
                // add songs playlist
                playListEntity.songList.add(
                  ref
                      .watch(currentSongsProvider)![
                          ref.watch(currentIndexProvider)!]
                      .data,
                );
                PlayListBoxUseCase.add(
                  PlayListEntity(
                    id: playListEntity.id,
                    playListName: playListEntity.playListName,
                    songList: playListEntity.songList,
                  ),
                );
                ref.invalidate(playListProvider);
              }

              Navigator.pop(context);
            },
          );
        },
        itemCount: ref.watch(playListProvider).length,
      ),
    ),
  );
}
