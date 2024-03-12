import 'package:zing/data/data_sources/audio_file_source/audio_file_source.dart';
import 'package:zing/data/data_sources/object_box-data_source/object_box_data_source.dart';
import 'package:zing/domain/entities/liked_song_entity/liked_song_entity.dart';
import 'package:zing/objectbox.g.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LikedSongBoxUseCase {
  static void add(LikedSongEntity songEntity) async {
    ObjectBoxDataSource.instance.likedSongBox.put(songEntity);
  }

  static void remove(int id) async {
    ObjectBoxDataSource.instance.likedSongBox.remove(id);
  }

  static Future<List<SongModel>> getSongs() async {
    try {
      List<SongModel> localSongs = await AudionFileSource().fetchAudio();
      List<LikedSongEntity> likedSongs =
          ObjectBoxDataSource.instance.likedSongBox.getAll();
      if (localSongs.isNotEmpty && likedSongs.isNotEmpty) {
        List<SongModel> song = [];
        for (SongModel songModel in localSongs) {
          for (LikedSongEntity likedSongEntity in likedSongs) {
            if (songModel.data == likedSongEntity.data) song.add(songModel);
          }
        }
        return song;
      } else {
        return [];
      }
    } catch (e) {
      throw "An error ocurred liked Songs";
    }
  }

  static LikedSongEntity? checkIsLiked(SongModel songModel) {
    final Query<LikedSongEntity> query = ObjectBoxDataSource
        .instance.likedSongBox
        .query(LikedSongEntity_.data.equals(songModel.data))
        .build();

    final List<LikedSongEntity> song = query.find();
    if (song.length == 1) {
      return song[0];
    }
    return null;
  }
}
