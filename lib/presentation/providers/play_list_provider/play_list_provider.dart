import 'package:music_app/domain/entities/play_list_entity/play_list_entity.dart';
import 'package:music_app/domain/usecases/playlist_use_case/play_list_box_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'play_list_provider.g.dart';

@riverpod
List<PlayListEntity> playList(PlayListRef ref) {
  return PlayListBoxUseCase.getPlayList();
}
