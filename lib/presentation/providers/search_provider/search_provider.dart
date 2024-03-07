import 'package:music_app/data/data_sources/audio_file_source/audio_file_source.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

@riverpod
class Search extends _$Search {
  @override
  List<SongModel>? build() {
    return [];
  }

  void searchSong(String query) async {
    List<SongModel> songList = await AudionFileSource().fetchAudio();
    if (songList.isNotEmpty) {
      RegExp specialCharsRegExp = RegExp(r'[^\w\s]');
      RegExp regExp = RegExp(
        query.replaceAll(specialCharsRegExp, '').toLowerCase(),
      );
      state = [
        for (SongModel song in songList)
          if (regExp.hasMatch(song.title.toLowerCase())) song
      ];
      if (state!.isEmpty) {
        state = null;
      }
    } else {
      state = null;
    }
  }
}
