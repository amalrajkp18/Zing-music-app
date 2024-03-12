import 'package:music_app/domain/usecases/playlist_use_case/play_list_box_use_case.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'play_list_songs_provider.g.dart';

@riverpod
Future<List<SongModel>> playListSongs(PlayListSongsRef ref,
    {required List<String> songData}) {
  return PlayListBoxUseCase.getSongs(songData);
}
