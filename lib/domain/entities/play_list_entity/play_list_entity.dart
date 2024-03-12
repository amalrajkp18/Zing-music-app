import 'package:objectbox/objectbox.dart';

@Entity()
class PlayListEntity {
  @Id()
  int id;

  List<String> songList;

  final String playListName;

  PlayListEntity(
      {this.id = 0, this.songList = const [], required this.playListName});
}
