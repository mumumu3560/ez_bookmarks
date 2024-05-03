
import 'package:drift/native.dart';
import 'package:ez_bookmarks/i18n/strings.g.dart';
import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:flutter/material.dart';
import 'package:ez_bookmarks/database/drift/database_1/database.dart';

import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future<Map<String, List<Tag>>> getTagsByGenre(WidgetRef ref) async {
    
    

    final dbAd = ref.read(dbAdminNotifierProvider);

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





// ブックマークを追加するメソッド（具体的なロジックは省略）
  void editBookmark(WidgetRef ref,  BuildContext context, String contents, String existedUrl,String url, List<String> tags, String? imagePath, int bookmarkId) async {

    final dbAd = ref.watch(dbAdminNotifierProvider);
    final translations = Translations.of(context);

    final unexpectedErrorMessage = translations.utils.unexpected;
    try{
      if(url == ""){
        context.showErrorSnackBar(message: translations.edit_bookmarks.snackbar.url_confirm);
        return;
      }


      final bool isExistUrl = await ref.watch(dbAdminNotifierProvider).checkBookmarkWithUrl(url);

      if(isExistUrl && existedUrl != url){
        if(context.mounted){
          context.showErrorSnackBar(message: translations.edit_bookmarks.snackbar.existing_confirm);
        }
        return;
      }


      await dbAd.updateBookmarkWithTags(
        bookmarkId,
        contents, 
        url, 
        tags, 
        imagePath,
      );

      // ここでタグのジャンルをGenreColorsテーブルに挿入または更新
    for (final tagName in tags) {
      //final tagId = await myDatabase.getTagIdByName(tagName);
      final tagId = await dbAd.getTagIdByName(tagName);
      //await myDatabase.insertOrUpdateGenreColor(tagId!, "分類なし", false); // ジャンルは適宜設定または選択させる
      
      //ここは多言語化でadd_bookmarkのon_insertを使う。
      //await dbAd.insertOrUpdateGenreColor(tagId!, "分類なし", false); 
      
      //await dbAd.insertOrUpdateGenreColor(tagId!, translations.add_bookmarks.on_insert.genre, false); // ジャンルは適宜設定または選択させる
    
      await dbAd.insertOrUpdateGenreColor(tagId!, "分類なし", false); 
    }
      


      if(context.mounted){
        Navigator.pop(context); // 成功後、ページを閉じる
      }

    } on SqliteException {
      //if(mounted) context.showErrorSnackBar(message: e.toString());
      if(context.mounted) context.showErrorSnackBar(message: translations.edit_bookmarks.snackbar.existing_confirm);
    } catch (e) {
      if(context.mounted) context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }