import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ez_bookmarks/database/drift/database_1/database.dart';

part 'genres_watcher.g.dart';

@riverpod
class GenresWatcherNotifier extends _$GenresWatcherNotifier{

  @override
  List<Genre> build() {

    return [];
  }

  void updateState(List<Genre> value) {
    state = value;
  }  


}