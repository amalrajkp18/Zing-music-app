import 'dart:developer';

import 'package:on_audio_query/on_audio_query.dart';

class AudionFileSource {
  final OnAudioQuery onAudioQuery = OnAudioQuery();

  Future<List<SongModel>> fetchAudio() async {
    try {
      List<SongModel> songsList = await onAudioQuery.querySongs(
        sortType: SongSortType.TITLE,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );
      return songsList;
    } catch (e) {
      log(e.toString());
      throw "Exception Occured";
    }
  }
}
