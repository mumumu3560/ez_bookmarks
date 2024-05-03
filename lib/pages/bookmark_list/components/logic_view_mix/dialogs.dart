import 'package:ez_bookmarks/database/drift/database_1/database.dart';
import 'package:ez_bookmarks/i18n/strings.g.dart';
import 'package:ez_bookmarks/pages/bookmark_list/bookmark_list_page.dart';
import 'package:ez_bookmarks/riverpod/aspect/aspect_switcher.dart';
import 'package:ez_bookmarks/riverpod/axis_count/axis_count_switcher.dart';
import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:ez_bookmarks/riverpod/sort_bookmarks/sort_kind_switcher.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ez_bookmarks/riverpod/desc_or_asc/desc_or_asc_switcher.dart';







//TODO: ここでダイアログを表示する関数を作成する。
void showSelectedTagsDialog(BuildContext context, List<Tag>? tags){
  final translations = Translations.of(context);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(translations.home.selected_tags_dialog.title),
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
            child: Text(translations.home.selected_tags_dialog.close),
          ),
        ],
      );
    },
  );
}






















//ここではソートの方法を表示するdialogを表示する。
//checkBoxで昇順か降順かを選択する。

void showSettingSortDialog(BuildContext context) {
  final translocations = Translations.of(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(translocations.home.setting_list.sort_dialog.title),
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
                    title: Text(translocations.home.setting_list.sort_dialog.descending),
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
                    'createdAt': translocations.home.setting_list.sort_dialog.sort_list.created,
                    'updatedAt': translocations.home.setting_list.sort_dialog.sort_list.updated,
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
            child: Text(translocations.home.setting_list.sort_dialog.close),
          ),
        ],
      );
    },
  );
}








//ここではbookmarkの詳細についてのダイアログを表示する。
//具体的にはブックマークの説明、制作日、更新日、閲覧数を表示する。
void showDetailDialog(BuildContext context, String content, List<String> tags) {

  final translations = Translations.of(context);



  showDialog(
    //縦の大きさを変えたい
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(translations.bookmark_card.setting_list.expain_dialog.title),
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
            child: Text(translations.bookmark_card.setting_list.expain_dialog.close),
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
  final translocations = Translations.of(context);

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
        title: Text(translocations.home.setting_list.grid_dialog.title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
          
          
              Consumer(
                builder: (context, ref, child) {
                  final crossAxisCountNotifier = ref.watch(axisCountSwitcherNotifierProvider);
                  return ListTile(
                    title: Text(translocations.home.setting_list.grid_dialog.grid_num),
                    subtitle: Column(
                      children: [
                        Text("${translocations.home.setting_list.grid_dialog.init_num}: ${isWide ? 4 : 2}"),
                        //Text('現在のグリッド数: $crossAxisCount'),
                        crossAxisCountNotifier.when(
                          data: (crossAxisCount) => Text('${translocations.home.setting_list.grid_dialog.now_num}: $crossAxisCount'),
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
                        label: '$crossAxisCount',
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
            child: Text(translocations.home.setting_list.grid_dialog.close),
          ),
        ],
      );
    },
  );
}


