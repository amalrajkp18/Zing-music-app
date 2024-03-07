import 'package:objectbox/objectbox.dart';

@Entity()
class LikedSongEntity {
  @Id()
  int id;
  String data;
  String title;
  String? artist;

  LikedSongEntity({
    this.id = 0,
    required this.data,
    required this.title,
    required this.artist,
  });
}
