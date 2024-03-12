import 'package:music_app/domain/entities/liked_song_entity/liked_song_entity.dart';
import 'package:music_app/domain/entities/play_list_entity/play_list_entity.dart';
import 'package:music_app/objectbox.g.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBoxDataSource {
  late final Store store;

  static ObjectBoxDataSource? _instance;

  static ObjectBoxDataSource get instance {
    return _instance!;
  }

  late final Box<LikedSongEntity> likedSongBox;
  late final Box<PlayListEntity> playListBox;

  ObjectBoxDataSource._create(this.store) {
    likedSongBox = store.box<LikedSongEntity>();
    playListBox = store.box<PlayListEntity>();
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<void> create() async {
    if (_instance == null) {
      final docsDir = await getApplicationDocumentsDirectory();
      final store = await openStore(directory: join(docsDir.path, "Zing"));
      _instance = ObjectBoxDataSource._create(store);
    }
  }
}
