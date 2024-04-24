
import 'package:drift/native.dart';
import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:flutter/material.dart';
import 'package:ez_bookmarks/database/drift/database_1/database.dart';

import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future<Map<String, List<Tag>>> getTagsByGenre(WidgetRef ref) async {
    
    //final allTags = await myDatabase.allTags; // 全てのタグを取得
    final allTags = await ref.watch(dbAdminNotifierProvider).allTags; // 全てのタグを取得
    Map<String, List<Tag>> tagsByGenre = {};

    for (final tag in allTags) {
      final genreName = tag.genre; // Tagエンティティにgenreフィールドが存在すると仮定
      //もしgenreNameがtagsByGenreに存在しない場合、新しいリストを作成して追加
      tagsByGenre.putIfAbsent(genreName, () => []);
      tagsByGenre[genreName]!.add(tag);
    }

    return tagsByGenre;
  }






// ブックマークを追加するメソッド（具体的なロジックは省略）
  Future<void> addBookmark(WidgetRef ref, BuildContext context, String contents, String url, List<String> tags, String? imagePath) async {

    try{
      if(url == ""){
        context.showErrorSnackBar(message: "URLを入力してください。");
        return;
      }

      final bool isExistUrl = await ref.watch(dbAdminNotifierProvider).checkBookmarkWithUrl(url);

      if(isExistUrl){
        if(context.mounted){
          context.showErrorSnackBar(message: "同じURLのブックマークが既に存在します。");
        }
        return;
      }



      await ref.watch(dbAdminNotifierProvider).insertBookmarkWithTags(
        contents, 
        url, 
        tags, 
        imagePath,
      );

      // ここでタグのジャンルをGenreColorsテーブルに挿入または更新
    for (final tagName in tags) {
      //final tagId = await myDatabase.getTagIdByName(tagName);
      final tagId = await ref.watch(dbAdminNotifierProvider).getTagIdByName(tagName);


      //await myDatabase.insertOrUpdateGenreColor(tagId!, "分類なし", true); // ジャンルは適宜設定または選択させる
      await ref.watch(dbAdminNotifierProvider).insertOrUpdateGenreColor(tagId!, "分類なし", true); // ジャンルは適宜設定または選択させる

    }
      

    } on SqliteException {
      //if(mounted) context.showErrorSnackBar(message: e.toString());
      if(context.mounted) context.showErrorSnackBar(message: "同じURLのブックマークが既に存在します。");
    } catch (e) {
      if(context.mounted) context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }









