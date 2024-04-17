
import 'package:ez_bookmarks/drift/database_1/database.dart';

import 'package:ez_bookmarks/utils/various.dart';


Future<Map<String, List<Tag>>> getTagsByGenre() async {
    
    final allTags = await myDatabase.allTags; // 全てのタグを取得
    Map<String, List<Tag>> tagsByGenre = {};

    for (final tag in allTags) {
      final genreName = tag.genre; // Tagエンティティにgenreフィールドが存在すると仮定
      //もしgenreNameがtagsByGenreに存在しない場合、新しいリストを作成して追加
      tagsByGenre.putIfAbsent(genreName, () => []);
      tagsByGenre[genreName]!.add(tag);
    }

    return tagsByGenre;
  }




