import 'package:ez_bookmarks/drift/database_1/database.dart';
import 'package:ez_bookmarks/pages/bookmark_list/bookmark_list_page.dart';
import 'package:ez_bookmarks/riverpod/aspect/aspect_switcher.dart';
import 'package:ez_bookmarks/riverpod/axis_count/axis_count_switcher.dart';
import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:ez_bookmarks/riverpod/sort_bookmarks/sort_kind_switcher.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ez_bookmarks/riverpod/desc_or_asc/desc_or_asc_switcher.dart';

/*
ここはlogicとviewが分けにくいと個人的に感じたダイアログをまとめるファイル
*/


void showSelectedTagsDialog(BuildContext context, List<Tag>? tags){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('選択したタグ'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: 8.0,
                children: tags?.map((tag) {
                  return ActionChip(
                    onPressed: () async {
                      
                    },
                    label: Text(tag.tagName),
                    //backgroundColor: Colors.blue,
                  );
                }).toList() ?? [],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // ダイアログを閉じる
            child: const Text('閉じる'),
          ),
        ],
      );
    },
  );
}











//ここでは削除確認のダイアログを表示する。
void showConfirmDialog(BuildContext context, Function onDelete) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('削除確認'),
        content: const Text('本当に削除しますか？'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () async {
              onDelete();
            },
            child: const Text('削除'),
          ),
        ],
      );
    },
  );
}












//ここではタグ選択ダイアログを表示する。
void showBookmarkTagsDialog(WidgetRef ref, BuildContext context, Bookmark bookmark, /* */List<int> tagSums, List<int> tagSumOnly, List<Tag>? tags) {
  // チェックボックスの状態を管理する変数
  bool includeWidgetTags = false;

  final dbAd = ref.watch(dbAdminNotifierProvider);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(  // StatefulBuilderを使用してダイアログ内の状態を管理
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('タグ一覧'),
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
                          const Text("And検索"),
              
                          IconButton(
                            icon: const Icon(Icons.help),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('And検索とは？'),
                                    content: const Text('選択したタグと、既に選択したタグ(左上)全てを含むブックマークを検索できます。'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(), // ダイアログを閉じる
                                        child: const Text('閉じる'),
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
                child: const Text('閉じる'),
              ),
            ],
          );
        },
      );
    },
  );
}


//ここではソートの方法を表示するdialogを表示する。
//checkBoxで昇順か降順かを選択する。

void showSettingSortDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('ソート変更'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              //昇順か降順かを選択する+ソートの方法を選択する。

              //昇順を表示し、チェックしたら降順にする。
              Consumer(
                builder: (context, ref, child) {
                  final isDesc = ref.watch(descOrAscSwitcherNotifierProvider);
                  
                  return CheckboxListTile(
                    title: const Text('降順'),
                    value: isDesc,
                    onChanged: (bool? value) {
                      final isDescNotifier = ref.read(descOrAscSwitcherNotifierProvider.notifier);
                      isDescNotifier.updateState(value!);
                    },
                  );
                }
              ),

              //ここではソートの方法を選択する。
              Consumer(
                builder: (context, ref, child) {
                  final sortKind = ref.watch(sortKindSwitcherNotifierProvider);
                  
                  //ソート方法は選択式にする。今はcreatedAtとupdatedAtのみ。
                  //createdAtは作成日、updatedAtは更新日として表示する。
                  //createdAt→作成日、updatedAt→更新日と表示
                  //DropDonwButtonを使って選択式にする。

                  Map<String, String> sortKindMap = {
                    'createdAt': '作成日時順',
                    'updatedAt': '更新日時順',
                  };

                  return DropdownButton<String>(
                    value: sortKind,
                    items: <String>['createdAt', 'updatedAt'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(sortKindMap[value]!),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      final sortKindNotifier = ref.read(sortKindSwitcherNotifierProvider.notifier);
                      sortKindNotifier.updateState(value!);
                    },
                  );

                }
              ),
              
              
              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // ダイアログを閉じる
            child: const Text('閉じる'),
          ),
        ],
      );
    },
  );
}








//ここではbookmarkの詳細についてのダイアログを表示する。
//具体的にはブックマークの説明、制作日、更新日、閲覧数を表示する。
void showDetailDialog(BuildContext context, String content, List<String> tags) {



  showDialog(
    //縦の大きさを変えたい
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('詳細'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Text(content),

              //制作日、更新日を表示する。具体的にはmyDatabaseから取得する。


              

 
          
    
          
          
          
              
              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              //Navigator.of(context).pop();
              Navigator.of(context).pop();
            }, // ダイアログを閉じる
            child: const Text('閉じる'),
          ),
        ],
      );
    },
  );



}

































//もともと縦横比とグリッド数を設定するダイアログを表示する関数
//ここではグリッド可変、アスペクト比固定のダイアログを表示する。


//グリッドに対するアスペクト比は固定にする。
Future<void> showSettingGridAndAspectDialog(BuildContext context) async{

  final bool isWide = SizeConfig.screenWidth! > 600;

  //グリッドに対するアスペクト比は固定にする。
  Map<int, double> aspectRatiosForWide = {
    3: 0.7,
    4: 0.6,
    5: 0.5,
  };

  Map<int, double> aspectRatiosForNarrow = {
    1: 1.0,
    2: 0.6,
    3: 0.5,
  };
  
  showDialog(
    //縦の大きさを変えたい
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('グリッド変更'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
          
          
              Consumer(
                builder: (context, ref, child) {
                  final crossAxisCountNotifier = ref.watch(axisCountSwitcherNotifierProvider);
                  return ListTile(
                    title: const Text('グリッド数'),
                    subtitle: Column(
                      children: [
                        Text("初期値: ${isWide ? 4 : 2}"),
                        //Text('現在のグリッド数: $crossAxisCount'),
                        crossAxisCountNotifier.when(
                          data: (crossAxisCount) => Text('現在のグリッド数: $crossAxisCount'),
                          loading: () => const CircularProgressIndicator(),
                          error: (error, stack) => Text('Error: $error'),
                        ),
                      ],
                    ),
                  );
                }
              ),
          
          
              Consumer(
                builder: (context, ref, child) {
                  final crossAxisCountNotifier = ref.watch(axisCountSwitcherNotifierProvider);
                  return crossAxisCountNotifier.when(
                    data: (crossAxisCount) {
                      // 画面の向きに応じて適切な範囲を設定
                      final minCount = isWide ? 3 : 1;
                      final maxCount = isWide ? 6 : 3;
                      // 範囲外の場合、範囲内の値に調整
                      if (crossAxisCount < minCount || crossAxisCount > maxCount) {
                        crossAxisCount = isWide ? 3 : (crossAxisCount > 3 ? 3 : crossAxisCount);
                        ref.read(axisCountSwitcherNotifierProvider.notifier).updateState(crossAxisCount);
                      }

                      return Slider(
                        value: crossAxisCount.toDouble(),
                        min: minCount.toDouble(),
                        max: maxCount.toDouble(),
                        divisions: isWide ? 3 : 2,
                        label: '$crossAxisCount列',
                        onChanged: (double value) {
                          ref.read(axisCountSwitcherNotifierProvider.notifier).updateState(value.toInt());
                          ref.read(aspectSwitcherNotifierProvider.notifier).updateState(
                            isWide ? aspectRatiosForWide[value.toInt()]! : aspectRatiosForNarrow[value.toInt()]!,
                          );
                        },
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stack) => Text('Error: $error'),
                  );
                }
              ),
 
          
    
          
          
          
              
              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              //Navigator.of(context).pop();
              Navigator.of(context).pop();
            }, // ダイアログを閉じる
            child: const Text('閉じる'),
          ),
        ],
      );
    },
  );
}




































/*


 */























/*

//ここではグリッドとアスペクト比ダイアログの形で設定する。
Future<void> showSettingGridAndAspectDialog(BuildContext context) async{

  final bool isWide = SizeConfig.screenWidth! > 600;
  
  showDialog(
    //縦の大きさを変えたい
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('グリッド変更'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
          
          
              Consumer(
                builder: (context, ref, child) {
                  final crossAxisCountNotifier = ref.watch(axisCountSwitcherNotifierProvider);
                  return ListTile(
                    title: Text('グリッド数'),
                    subtitle: Column(
                      children: [
                        Text("初期値: ${isWide ? 4 : 2}"),
                        //Text('現在のグリッド数: $crossAxisCount'),
                        crossAxisCountNotifier.when(
                          data: (crossAxisCount) => Text('現在のグリッド数: $crossAxisCount'),
                          loading: () => CircularProgressIndicator(),
                          error: (error, stack) => Text('Error: $error'),
                        ),
                      ],
                    ),
                  );
                }
              ),
          
          
              Consumer(
                builder: (context, ref, child) {
                  final crossAxisCountNotifier = ref.watch(axisCountSwitcherNotifierProvider);
                  return crossAxisCountNotifier.when(
                    data: (crossAxisCount) => Slider(
                      value: crossAxisCount.toDouble(),
                      //min: 2,
                      //max: 4,
                      //divisions: 2,
          
                      min: isWide ? 3 : 1,
                      max: isWide ? 6 : 3,
                      divisions: isWide ? 3 : 2,
                      label: crossAxisCount.toString(),
                      onChanged: (double value) {
                        ref.read(axisCountSwitcherNotifierProvider.notifier).updateState(value.toInt());
                      },
                    ),
                    loading: () => CircularProgressIndicator(),
                    error: (error, stack) => Text('Error: $error'),
                  );
                }
              ),
          
          
              Consumer(
                builder: (context, ref, child) {
                  final aspectRatioNotifier = ref.watch(aspectSwitcherNotifierProvider);
                  
                  return ListTile(
                    title: Text('アスペクト比'),
                    subtitle: Column(
                      children: [
                        Text("初期値: ${isWide ? 0.75 : 0.4}"),
                        //Text('現在のアスペクト比: $aspect'),
                        aspectRatioNotifier.when(
                          data: (aspect) => Text('現在のアスペクト比: $aspect'),
                          loading: () => CircularProgressIndicator(),
                          error: (error, stack) => Text('Error: $error'),
                        ),
                      ],
                    ),
                  );
                }
              ),
          
          
              /*
              Consumer(
                builder: (context, ref, child) {
                  final aspectRatioNotifier = ref.watch(aspectSwitcherNotifierProvider);
                  final crossAxisCountNotifier = ref.watch(axisCountSwitcherNotifierProvider);
                  
                  return aspectRatioNotifier.when(
                    data: (aspect) => Slider(
                      value: aspect,
                      //min: 0.3,
                      //max: 0.75,
                      //divisions: 9,
                      
                      divisions: isWide 
                        ? 8 
                        //: 6,
                        : crossAxisCountNotifier.when(
                            data: (crossAxisCount) => crossAxisCount == 3 ? 3 : 6,
                            loading: () => 8,
                            error: (error, stack) => 8,
                          ),
          
                      min: isWide 
                        ? 0.5 
                        : 0.3,
          
                        /*
                        : crossAxisCountNotifier.when(
                            data: (crossAxisCount) => crossAxisCount == 3 ? 0.25 : 0.3,
                            loading: () => 0.5,
                            error: (error, stack) => 0.5,
                          ),
                         */
                        
          
          
                      max: isWide 
                        ? 0.9 
                        //: 0.6,
                        : crossAxisCountNotifier.when(
                            data: (crossAxisCount) => crossAxisCount == 3 ? 0.4 : 0.6,
                            loading: () => 0.5,
                            error: (error, stack) => 0.5,
                          ),
                      
                      label: aspect.toString(),
                      onChanged: (double value) {
                        ref.read(aspectSwitcherNotifierProvider.notifier).updateState(value);
                      },
                    ),
                    loading: () => CircularProgressIndicator(),
                    error: (error, stack) => Text('Error: $error'),
                  );
                }
              ),
               */
          
              
          
              Consumer(
                builder: (context, ref, child) {
                  final aspectRatioNotifier = ref.watch(aspectSwitcherNotifierProvider);
                  final crossAxisCountNotifier = ref.watch(axisCountSwitcherNotifierProvider);
          
                  return crossAxisCountNotifier.when(
                    data: (crossAxisCount) {
                      final divisions = crossAxisCount == 3 ? 3 : 6;
                      final min = crossAxisCount == 3 ? 0.3 : (isWide ? 0.5 : 0.3);
                      final max = crossAxisCount == 3 ? 0.45 : (isWide ? 0.9 : 0.6);
          
                      return aspectRatioNotifier.when(
                        data: (aspect) {
                          // スライダーの値を範囲内に設定
                          double validValue = aspect;
                          if (validValue < min) {
                            validValue = min;
                          } else if (validValue > max) {
                            validValue = max;
                          }
          
                          return Slider(
                            value: validValue,
                            min: min,
                            max: max,
                            divisions: divisions,
                            label: validValue.toString(),
                            onChanged: (double newValue) async {
                              if (newValue < min) {
                                newValue = min;
                              } else if (newValue > max) {
                                newValue = max;
                              }
                              // ステートを更新
                              await ref.read(aspectSwitcherNotifierProvider.notifier).updateState(newValue);
                            },
                          );
                        },
                        loading: () => CircularProgressIndicator(),
                        error: (error, stack) => Text('Error: $error'),
                      );
                    },
                    loading: () => CircularProgressIndicator(),
                    error: (error, stack) => Text('Error: $error'),
                  );
                }
              ),
          
          
          
          
              
              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              //Navigator.of(context).pop();
              Navigator.of(context).pop();
            }, // ダイアログを閉じる
            child: Text('閉じる'),
          ),
        ],
      );
    },
  );
}
 */