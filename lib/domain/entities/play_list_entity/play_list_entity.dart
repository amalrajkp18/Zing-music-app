import 'package:objectbox/objectbox.dart';
import 'package:on_audio_query/on_audio_query.dart';

@Entity()
class PlayListEntity {
  @Id()
  int id;

  String tittle;
  List<SongModel>? songsList;

  PlayListEntity({this.id = 0, required this.tittle, this.songsList});
}
