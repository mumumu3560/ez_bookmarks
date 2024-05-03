


//ここではタグ選択ダイアログを表示する。
import 'package:ez_bookmarks/database/drift/database_1/database.dart';
import 'package:ez_bookmarks/i18n/strings.g.dart';
import 'package:ez_bookmarks/pages/bookmark_list/bookmark_list_page.dart';
import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void showBookmarkTagsDialog(WidgetRef ref, BuildContext context, Bookmark bookmark, /* */List<int> tagSums, List<int> tagSumOnly, List<Tag>? tags) {
  // チェックボックスの状態を管理する変数
  bool includeWidgetTags = false;

  final dbAd = ref.watch(dbAdminNotifierProvider);

  final translations = Translations.of(context);


  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(  // StatefulBuilderを使用してダイアログ内の状態を管理
        builder: (context, setState) {
          return AlertDialog(
            title: Text(translations.bookmark_card.setting_list.tag_dialog.title),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: 8.0,
                    children: bookmark.tags?.map((tag) {
                      final tagIndex = bookmark.tags!.indexOf(tag);
                      return ActionChip(
                        onPressed: () async {
                          //final tagId = await myDatabase.getTagIdByName(tag);
                          final tagId = await dbAd.getTagIdByName(tag);


                          //final thisTag = await myDatabase.getTagById(tagId!);

                          final thisTag = await dbAd.getTagById(tagId!);

                          
                          if(context.mounted){
                            final List<Tag> updatedTags = includeWidgetTags ? List.from(tags ?? []) : [];

                            final List<Tag> nowTags = tags ?? [];
                            
                            if(nowTags.contains(thisTag)){
                            
                              return;
                            }
                            else{
                              updatedTags.add(thisTag);
              
                              Navigator.of(context).pop();

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BookMarkList(tags: updatedTags,),
                                )
                              );
              
                            }
                            
                          }
                        },
                        label: Text("$tag : ${includeWidgetTags ? tagSums[tagIndex] : tagSumOnly[tagIndex]}"),
                        //backgroundColor: Colors.blue,
                      );
                    }).toList() ?? [],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: includeWidgetTags,
                        onChanged: (bool? value) {
                         
                          // setStateを使ってチェックボックスの状態を更新
                          setState(() {
                            includeWidgetTags = value!;
                          });
                        },
                      ),
                      Row(
                        children: [
                          Text(translations.bookmark_card.setting_list.tag_dialog.search),
              
                          IconButton(
                            icon: const Icon(Icons.help),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(translations.bookmark_card.setting_list.tag_dialog.and_search.title),
                                    content: Text(translations.bookmark_card.setting_list.tag_dialog.and_search.text),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(), // ダイアログを閉じる
                                        child: Text(translations.bookmark_card.setting_list.tag_dialog.and_search.close),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(), // ダイアログを閉じる
                child: Text(translations.bookmark_card.setting_list.tag_dialog.close),
              ),
            ],
          );
        },
      );
    },
  );
}






//ここでは削除確認のダイアログを表示する。
void showDeleteConfirmDialog(BuildContext context, Function onDelete) {
  final translations = Translations.of(context);

  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(translations.bookmark_card.setting_list.delete_dialog.title),
        content: Text(translations.bookmark_card.setting_list.delete_dialog.confirm),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(translations.bookmark_card.setting_list.delete_dialog.cancel),
          ),
          TextButton(
            onPressed: () async {
              onDelete();
            },
            child: Text(translations.bookmark_card.setting_list.delete_dialog.delete),
          ),
        ],
      );
    },
  );
}
