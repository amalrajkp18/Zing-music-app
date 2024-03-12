import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zing/domain/entities/play_list_entity/play_list_entity.dart';
import 'package:zing/domain/usecases/playlist_use_case/play_list_box_use_case.dart';
import 'package:zing/presentation/pages/library/play_list_page/play_list_songs_page.dart';
import 'package:zing/presentation/widgets/library_tile_widget.dart';
import 'package:zing/presentation/widgets/play_list_title_control_widget.dart';
import 'package:zing/presentation/providers/play_list_provider/play_list_provider.dart';

class PlayListBuilderWidget extends ConsumerWidget {
  const PlayListBuilderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController playListEditingController = TextEditingController();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        PlayListEntity playListEntity = ref.watch(playListProvider)[index];

        return LibraryTileWidget(
          title: playListEntity.playListName,
          songCount: "${playListEntity.songList.length} songs playlist",
          onTap: () {
            // Navigate to page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayListSongPage(
                  title: playListEntity.playListName,
                  songList: playListEntity.songList,
                  id: playListEntity.id,
                ),
              ),
            );
          },
          trailing: PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == '/delete') {
                // delete playlist
                PlayListBoxUseCase.remove(playListEntity.id);

                ref.invalidate(playListProvider);
              } else if (value == '/edit') {
                playListEditingController.text = playListEntity.playListName;
                playlistTtileControlWidget(
                  context: context,
                  textEditingController: playListEditingController,
                  isEdit: true,
                  onPressed: () {
                    // edit playlist name
                    if (playListEditingController.text.isNotEmpty) {
                      PlayListBoxUseCase.add(
                        PlayListEntity(
                          id: playListEntity.id,
                          playListName: playListEditingController.text,
                          songList: playListEntity.songList,
                        ),
                      );
                      Navigator.pop(context);
                      ref.invalidate(playListProvider);
                      playListEditingController.clear();
                    }
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
        );
      },
      itemCount: ref.watch(playListProvider).length,
    );
  }
}
