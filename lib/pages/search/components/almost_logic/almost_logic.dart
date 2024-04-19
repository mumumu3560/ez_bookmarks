
import 'package:ez_bookmarks/drift/database_1/database.dart';
import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';

import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';













  

  Future<void> changeTagGenre(WidgetRef ref, int tagId, String newGenre) async {
    // ジャンルがGenresテーブルに存在するか確認

    final dbAd = ref.read(dbAdminNotifierProvider);
    //final existingGenre = await myDatabase.genreExists(newGenre);
    final existingGenre = await dbAd.genreExists(newGenre);

  // 存在しない場合、新しいジャンルを追加
  if (!existingGenre) {
    //await myDatabase.insertGenre(newGenre);
    await dbAd.insertGenre(newGenre);
  }

    //await myDatabase.updateTagGenre(tagId, newGenre);
    await dbAd.updateTagGenre(tagId, newGenre);

    //await myDatabase.insertOrUpdateGenreColor(tagId, newGenre, false);
    await dbAd.insertOrUpdateGenreColor(tagId, newGenre, false);
    
  }



  

  Future<int> calcContainBookmarks(WidgetRef ref, List<Tag> tags, String sortBy, bool isDesc) async{
    final dbAd = ref.read(dbAdminNotifierProvider);
    //final filterdList = await myDatabase.findBookmarksContainingAllTags(tags, sortBy, isDesc);
    final filterdList = await dbAd.findBookmarksContainingAllTags(tags, sortBy, isDesc);
    return filterdList.length;
  }







  Future<Map<String, List<Tag>>> getTagsByGenre(WidgetRef ref) async {

  final dbAd = ref.watch(dbAdminNotifierProvider);
    
    //final allTags = await myDatabase.allTags; // 全てのタグを取得
    final allTags = await dbAd.allTags; // 全てのタグを取得
    Map<String, List<Tag>> tagsByGenre = {};

    for (final tag in allTags) {
      final genreName = tag.genre; // Tagエンティティにgenreフィールドが存在すると仮定
      //もしgenreNameがtagsByGenreに存在しない場合、新しいリストを作成して追加
      tagsByGenre.putIfAbsent(genreName, () => []);
      tagsByGenre[genreName]!.add(tag);
    }

    return tagsByGenre;
  }
