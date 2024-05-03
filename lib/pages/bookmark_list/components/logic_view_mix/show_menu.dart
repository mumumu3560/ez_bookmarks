import 'package:ez_bookmarks/i18n/strings.g.dart';
import 'package:ez_bookmarks/pages/bookmark_list/components/logic_view_mix/dialogs.dart';
import 'package:ez_bookmarks/riverpod/firebase_analytics/analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



void showBookmarkSettings(WidgetRef ref, TapDownDetails details, BuildContext context) {
  //その場に表示するメニューを作成
  final position = details.globalPosition;
  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  final translations = Translations.of(context);

  final RelativeRect positionPopup = RelativeRect.fromLTRB(
    position.dx,
    position.dy,
    overlay.size.width - position.dx,
    overlay.size.height - position.dy,
  );

  showMenu(
    context: context,
    position: positionPopup,
    items: [

      PopupMenuItem(
        child: ListTile(
          leading: const Icon(Icons.grid_on),
          title: Text(translations.home.setting_list.grid),
          onTap: () async{
            
            await FirebaseAnalytics.instance.logEvent(
              name: "グリッドを変更する",
              parameters: <String, dynamic>{
                'button_name': 'example_button',
              },
            );

            //ここでdialogを出して、縦横比とグリッド数を変更させる。

            if(context.mounted){
              Navigator.of(context).pop();

              showSettingGridAndAspectDialog(context);
            }

          },
        ),
      ),


      PopupMenuItem(
        child: ListTile(
          leading: const Icon(Icons.sort),
          title: Text(translations.home.setting_list.sort),
          onTap: () async{
            //ここでdialogを出して、縦横比とグリッド数を変更させる。

            Navigator.of(context).pop();

            showSettingSortDialog(context); 

          },
        ),
      ),



      /*
      PopupMenuItem(
        child: ListTile(
          leading: const Icon(Icons.help),
          title: const Text('ヘルプ'),
          onTap: () {
            final analyticsNotifier = ref.read(analyticsNotifierProvider.notifier);

            analyticsNotifier.onEventOccur("ヘルプボタンが押されました。");

            /*
            FirebaseAnalytics.instance.logEvent(
              name: "push_help_button",
              parameters: <String, dynamic>{
                'button_name': 'example_button',
              },
            );
              */

            Navigator.of(context).pop();

          },
        ),
      ),
       */
    ],
  );
}




void showBookmarkSettingsWithTags(WidgetRef ref, TapDownDetails details, BuildContext context){
  //その場に表示するメニューを作成
  final position = details.globalPosition;
  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  final translocations = Translations.of(context);

  final RelativeRect positionPopup = RelativeRect.fromLTRB(
    position.dx,
    position.dy,
    overlay.size.width - position.dx,
    overlay.size.height - position.dy,
  );

  showMenu(
    context: context,
    position: positionPopup,
    items: [

      PopupMenuItem(
        child: ListTile(
          leading: const Icon(Icons.grid_on),
          title: Text(translocations.home.setting_list.grid),
          onTap: () async{

            Navigator.of(context).pop();

            showSettingGridAndAspectDialog(context);

          },
        ),
      ),


      PopupMenuItem(
        child: ListTile(
          leading: const Icon(Icons.sort),
          title: Text(translocations.home.setting_list.sort),
          onTap: () async{
            //ここでdialogを出して、縦横比とグリッド数を変更させる。

            Navigator.of(context).pop();

            showSettingSortDialog(context); 

          },
        ),
      ),




    ],
  );
}