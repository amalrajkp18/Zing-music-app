import 'package:on_audio_query/on_audio_query.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_songs_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentSongs extends _$CurrentSongs {
  @override
  List<SongModel>? build() {
    return [];
  }

  void addSongs(List<SongModel>? songs) {
    state = songs;
  }
}
