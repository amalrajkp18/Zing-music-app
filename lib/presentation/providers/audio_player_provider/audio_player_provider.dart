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
final playStateProvider = StateProvider<bool>((ref) => false);

///play bar is visble or not
final playBarProvider = StateProvider<bool>((ref) => false);

final shuffleStateProvider = StateProvider<bool>((ref) => false);

final repeatStateProvider = StateProvider<bool>((ref) => false);
