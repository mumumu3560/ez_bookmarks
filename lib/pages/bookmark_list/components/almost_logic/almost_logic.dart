import 'dart:io';

import 'package:ez_bookmarks/drift/database_1/database.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;


/*
ここではほとんどlogicだけで構成されているファイル
 */

//ここではブックマークが含むタグをreturn
Future<int> calcContainBookmarks(List<Tag> tags, String sortBy, bool isDesc) async{
  final filterdList = await myDatabase.findBookmarksContainingAllTags(tags, sortBy, isDesc);
  return filterdList.length;
}


//時刻をフォーマットする。
String formatCreatedAt(DateTime createdAt) {

  DateTime now = DateTime.now().toLocal();

  Duration difference = now.difference(createdAt);

  if (difference.inMinutes < 60) {
    return '${difference.inMinutes}分前';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}時間前';
  } else if (difference.inDays < 365) {
    return '${createdAt.month}月${createdAt.day}日';
  } else {
    return '${createdAt.year}年${createdAt.month}月${createdAt.day}日';
  }
}

//ここではそのタグのみを含むブックマークと、そのタグ＋他のタグを含むブックマークの数を計算する。
Future<Map<int,List<int>>> calcSums (BuildContext context, Bookmark bookmark, List<Tag>? tags, String sortBy, bool isDesc) async{
  List<int> tagSums = [];
  List<int> tagSumOnlys = [];

  for(int i = 0; i < bookmark.tags!.length; i++){
    final tagId = await myDatabase.getTagIdByName(bookmark.tags![i]);
    final tag = await myDatabase.getTagById(tagId!);

    final List<Tag> updatedTags = List.from(tags ?? []);
    updatedTags.add(tag);

    final tagSum = await calcContainBookmarks(updatedTags, sortBy, isDesc);
    tagSums.add(tagSum);

    final tagSumOnly = await calcContainBookmarks([tag], sortBy, isDesc);
    tagSumOnlys.add(tagSumOnly);
  }

  //tagSumsとtagSumOnlysをmapでまとめる
  Map<int,List<int>> sums = {0:tagSums, 1:tagSumOnlys};

  return sums;
  /*
  if(context.mounted){
    showTagsDialog(context, bookmark, tagSums, tagSumOnlys, tags); 
  }
   */
}






Future<String?> fetchURLData(String url) async {

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var document = parse(response.body);
        var metas = document.head!.getElementsByTagName('meta');
        Image? image;
        String? imageUrl;

        for(var meta in metas){
          if (meta.attributes['property'] == 'og:image') {
            image = Image.network(
              meta.attributes['content']!,
            );   
            imageUrl = meta.attributes['content']!;
          }
        }

        //return image!;
        return imageUrl!;
      }
      else{
        //return Image.asset('assets/images/no_image.png');
        return null;

      }
    } catch (e) {
      //return Image.asset('assets/images/no_image.png');
      return null;
    }
  }








  Future<Widget> createImageWidget(String? imagePath) async {
  // imagePathがnullでないかつファイルが存在する場合
  if (imagePath != null && await File(imagePath).exists()) {
    return Image.file(File(imagePath), fit: BoxFit.cover);
  } else {
    // ファイルが存在しない場合はデフォルト画像を表示
    return Image.asset('assets/images/no_image.png', fit: BoxFit.cover);
  }
}






Future<Widget> loadImage(String? imagePath, String? url) async {
  if (imagePath != null) {
    bool exists = await File(imagePath).exists();
    if (exists) {
      return Image.file(File(imagePath), fit: BoxFit.cover);
    }
  }
  
  if (url != null) {
    try {
      String? imageUrl = await fetchURLData(url);
      if (imageUrl != null) {
        return Image.network(imageUrl, fit: BoxFit.cover);
      }
    } catch (e) {
      // Log error or handle exception
    }
  }
  
  // デフォルトの画像を返す
  return Image.asset('assets/images/no_image.png', fit: BoxFit.cover);
}
