import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/Song.dart';

part 'home_local_repository.g.dart';

@riverpod
HomeLocalRepository homeLocalRepository(HomeLocalRepositoryRef ref) {
  return HomeLocalRepository();
}

class HomeLocalRepository {
  final Box _box = Hive.box("home");
  

  void uploadSong(Song song) {
    _box.put(song.id, song.toJson());
  }

  List<Song> loadSongs() {
    final List<Song> songs = [];
    for (var i = 0; i < _box.length; i++) {
      songs.add(Song.fromJson(_box.getAt(i)));
    }
    return songs;
  }


}
