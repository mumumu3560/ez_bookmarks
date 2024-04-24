import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ez_bookmarks/database/drift/database_1/database.dart';

part 'tags_watcher.g.dart';

@riverpod
class TagsWatcherNotifier extends _$TagsWatcherNotifier{

  @override
  List<Tag> build() {

    return [];
  }

  //ここでSortKindを変更する。
  void addTag(Tag tag) {
    state.add(tag);
  }

  void removeTag(Tag tag) {
    state.remove(tag);
  }

  void clearTags(){
    state.clear();
  }

  


}