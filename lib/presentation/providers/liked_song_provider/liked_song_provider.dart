import 'package:zing/domain/usecases/liked_song_uses_case/liked_song_box_use_case.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'liked_song_provider.g.dart';

@riverpod
Future<List<SongModel>> likedSongs(LikedSongsRef ref) {
  return LikedSongBoxUseCase.getSongs();
}
