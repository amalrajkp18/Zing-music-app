import 'package:music_app/data/data_sources/object_box-data_source/object_box_data_source.dart';
import 'package:music_app/domain/entities/liked_song_entity/liked_song_entity.dart';
import 'package:music_app/objectbox.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'liked_song_provider.g.dart';

@riverpod
class LikedSong extends _$LikedSong {
  @override
  List<LikedSongEntity> build() {
    return orderSongs();
  }

  void addSong(LikedSongEntity songEntity) {
    ObjectBoxDataSource.instance.likedSongBox.put(songEntity);
    state = List.from(orderSongs());
  }

  void removeSong(int id) {
    ObjectBoxDataSource.instance.likedSongBox.remove(id);
    state = List.from(orderSongs());
  }

  List<LikedSongEntity> orderSongs() {
    final Query<LikedSongEntity> query = ObjectBoxDataSource
        .instance.likedSongBox
        .query()
        .order(LikedSongEntity_.title)
        .build();
    return query.find();
  }
}
