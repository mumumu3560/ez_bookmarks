
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
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






// ブックマークを追加するメソッド（具体的なロジックは省略）
  void addBookmark(BuildContext context, String contents, String url, List<String> tags, String? imagePath) async {

    try{
      if(url == ""){
        context.showErrorSnackBar(message: "URLを入力してください。");
        return;
      }

      await myDatabase.insertBookmarkWithTags(
        contents, 
        url, 
        tags, 
        imagePath,
      );

      // ここでタグのジャンルをGenreColorsテーブルに挿入または更新
    for (final tagName in tags) {
      final tagId = await myDatabase.getTagIdByName(tagName);
      await myDatabase.insertOrUpdateGenreColor(tagId!, "分類なし", true); // ジャンルは適宜設定または選択させる
    }
      


      if(context.mounted){
        Navigator.pop(context); // 成功後、ページを閉じる
      }

    } on SqliteException {
      //if(mounted) context.showErrorSnackBar(message: e.toString());
      if(context.mounted) context.showErrorSnackBar(message: "同じURLのブックマークが既に存在します。");
    } catch (e) {
      if(context.mounted) context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }













  // ブックマークを追加するメソッド（具体的なロジックは省略）
  /*
  void _addBookmark() async {

    try{
      if(_urlController.text == ""){
        context.showErrorSnackBar(message: "URLを入力してください。");
        return;
      }

      await myDatabase.insertBookmarkWithTags(
        _contentsController.text, 
        _urlController.text, 
        tags, 
        imagePath,
      );

      // ここでタグのジャンルをGenreColorsテーブルに挿入または更新
    for (final tagName in tags) {
      final tagId = await myDatabase.getTagIdByName(tagName);
      await myDatabase.insertOrUpdateGenreColor(tagId!, "分類なし", true); // ジャンルは適宜設定または選択させる
    }
      


      if(mounted){
        Navigator.pop(context); // 成功後、ページを閉じる
      }

    } on SqliteException catch (e) {
      //if(mounted) context.showErrorSnackBar(message: e.toString());
      if(mounted) context.showErrorSnackBar(message: "同じURLのブックマークが既に存在します。");
    } catch (e) {
      if(mounted) context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }
   */