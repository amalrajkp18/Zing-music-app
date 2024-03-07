import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_player_provider.g.dart';

/// audio player controller
@Riverpod(keepAlive: true)
AudioPlayer audioPlayer(AudioPlayerRef ref) {
  return AudioPlayer();
}

/// is playing or not
final playStateProvider = Provider<bool>(
  (ref) => ref.watch(audioPlayerProvider).playing,
);

final shuffleStateProvider = StateProvider<bool>((ref) => false);

final repeatStateProvider = StateProvider<bool>((ref) => false);
