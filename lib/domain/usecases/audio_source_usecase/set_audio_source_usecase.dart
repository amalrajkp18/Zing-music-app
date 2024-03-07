import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SetAudioSourceUseCase {
  static ConcatenatingAudioSource set(List<SongModel> data) {
    // set audio source
    final List<AudioSource> audioSources = data
        .map(
          (source) => AudioSource.file(
            source.data,
            tag: MediaItem(
              id: '1',
              title: source.title,
              artist: source.artist,
            ),
          ),
        )
        .toList();
    return ConcatenatingAudioSource(children: audioSources);
  }
}
