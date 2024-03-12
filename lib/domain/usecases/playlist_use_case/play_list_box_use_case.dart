import 'package:zing/data/data_sources/audio_file_source/audio_file_source.dart';
import 'package:zing/data/data_sources/object_box-data_source/object_box_data_source.dart';
import 'package:zing/domain/entities/play_list_entity/play_list_entity.dart';
import 'package:zing/objectbox.g.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListBoxUseCase {
  static void add(PlayListEntity playListEntity) {
    ObjectBoxDataSource.instance.playListBox.put(playListEntity);
  }

  static void remove(int id) {
    ObjectBoxDataSource.instance.playListBox.remove(id);
  }

  static List<PlayListEntity> getPlayList() {
    final Query<PlayListEntity> query = ObjectBoxDataSource.instance.playListBox
        .query()
        .order(PlayListEntity_.playListName)
        .build();

    return query.find();
  }

  static Future<List<SongModel>> getSongs(List<String> songData) async {
    try {
      List<SongModel> localSongs = await AudionFileSource().fetchAudio();
      if (localSongs.isNotEmpty && songData.isNotEmpty) {
        List<SongModel> song = [];
        for (SongModel songModel in localSongs) {
          for (String data in songData) {
            if (songModel.data == data) song.add(songModel);
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

  static bool isAlreadyExistSong({
    required int id,
    required String data,
  }) {
    PlayListEntity? playList = ObjectBoxDataSource.instance.playListBox.get(id);

    if (playList != null) {
      for (String songData in playList.songList) {
        if (songData == data) {
          return true;
        }
      }
    }
    return false;
  }
}
