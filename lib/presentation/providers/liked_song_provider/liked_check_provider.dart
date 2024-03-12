import 'package:zing/domain/entities/liked_song_entity/liked_song_entity.dart';
import 'package:zing/domain/usecases/liked_song_uses_case/liked_song_box_use_case.dart';
import 'package:zing/presentation/providers/liked_song_provider/liked_check_state.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'liked_check_provider.g.dart';

@riverpod
class LikedCheck extends _$LikedCheck {
  @override
  LikedCheckState build() {
    return LikedCheckState(isLiked: false);
  }

  void isLiked(SongModel songModel) {
    LikedSongEntity? songEntity = LikedSongBoxUseCase.checkIsLiked(songModel);
    state = songEntity != null
        ? LikedCheckState(isLiked: true, id: songEntity.id)
        : LikedCheckState(isLiked: false);
  }
}
