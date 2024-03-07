import 'package:music_app/data/data_sources/object_box-data_source/object_box_data_source.dart';
import 'package:music_app/domain/entities/liked_song_entity/liked_song_entity.dart';
import 'package:music_app/objectbox.g.dart';
import 'package:music_app/presentation/providers/liked_song_provider/liked_check_state.dart';
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
    final Query<LikedSongEntity> query = ObjectBoxDataSource
        .instance.likedSongBox
        .query(LikedSongEntity_.data.equals(songModel.data))
        .build();

    final List<LikedSongEntity> song = query.find();
    state = song.length == 1
        ? LikedCheckState(isLiked: true, id: song[0].id)
        : LikedCheckState(isLiked: false);
  }
}
