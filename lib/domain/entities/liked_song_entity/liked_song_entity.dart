import 'package:objectbox/objectbox.dart';

@Entity()
class LikedSongEntity {
  @Id()
  int id;

  String data;

  LikedSongEntity({this.id = 0, required this.data});
}
