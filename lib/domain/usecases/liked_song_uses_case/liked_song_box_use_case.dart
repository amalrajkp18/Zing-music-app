import 'package:music_app/data/data_sources/object_box-data_source/object_box_data_source.dart';
import 'package:music_app/domain/entities/liked_song_entity/liked_song_entity.dart';

class LikedSongBoxUseCase {
  static void add(LikedSongEntity songEntity) async {
    ObjectBoxDataSource.instance.likedSongBox.put(songEntity);
  }

  static void remove(int id) async {
    ObjectBoxDataSource.instance.likedSongBox.remove(id);
  }
}
