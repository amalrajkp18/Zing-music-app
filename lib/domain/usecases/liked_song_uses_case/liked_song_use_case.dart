import 'package:music_app/data/data_sources/audio_file_source/audio_file_source.dart';
import 'package:music_app/data/data_sources/object_box-data_source/object_box_data_source.dart';
import 'package:music_app/domain/entities/liked_song_entity/liked_song_entity.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LikedSongUseCase {
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
}
