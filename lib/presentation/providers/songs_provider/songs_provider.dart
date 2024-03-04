import 'package:music_app/data/data_sources/audio_file_source/audio_file_source.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'songs_provider.g.dart';

@riverpod
Future<List<SongModel>> songs(SongsRef ref) {
  return AudionFileSource().fetchAudio();
}
