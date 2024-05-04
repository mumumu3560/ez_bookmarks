import 'package:ez_bookmarks/i18n/strings.g.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ez_bookmarks/pages/search/components/almost_view/help_widget.dart';

  /*
  void showImportHelpDialog(BuildContext context){
    //ここでダイアログを表示する
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text('注意'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'インポートを行うと、現在のデータベースが上書きされます。\n\nインポート前に確認を行ってください。'
              , style: TextStyle(fontSize: 16),
            )
          ],
        ),



        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: const Text('閉じる')
          )
        ],
        
      )
    );

  }
   */

  /*
  void showBackupHelpDialog(BuildContext context){


    showDialog(
      
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text('注意'),
        insetPadding: const EdgeInsets.all(16),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: SizeConfig.blockSizeHorizontal! * 100,
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'バックアップファイルは\nclassifier_database_backup(1,2,3).sqlite\nという名前でダウンロードフォルダに保存されます。\n',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: const Text('閉じる')
          )
        ],

      )
    );




  }
   */









/*
const List<String> backupHelpContents = [
  'バックアップファイルは\nclassifier_database(1,2,3)_backup.sqlite\nという名前でダウンロードフォルダに保存されます。\n',
  '保存されるファイルの名前は\ndatabase1_backup1、database1_backup2\nのようになります。\n\nバックアップを取り続けると容量が圧迫されます。ダウンロードフォルダの整理を忘れないようにしてください',
];
 */

void showBackupHelpDialog(BuildContext context) {

  final translations = Translations.of(context);

  List<String> backupHelpContents = [
    translations.import_export.backup_dialog.page_1.text,
    translations.import_export.backup_dialog.page_2.text,
  ];


  showDialog(
    context: context,
    builder: (context) {
      final PageController pageController = PageController(initialPage: 0);
      final List<Widget> pages = [
        HelpPage(content: backupHelpContents[0], title: translations.import_export.backup_dialog.page_1.title),
        HelpPage(content: backupHelpContents[1], title: translations.import_export.backup_dialog.page_2.title),
      ];
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0), // 
        ),
        child: Container(
          height: SizeConfig.blockSizeVertical! * 60,  // 高さを適切に設定
          width: SizeConfig.blockSizeHorizontal! * 90,  // 幅を適切に設定
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: pages,
                ),
              ),
              SizedBox(height: 10,),
              SmoothPageIndicator(
                controller: pageController,
                count: pages.length,
                effect: WormEffect(),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      );
    },
  );
}












Future<bool> showConfirmBackUpDialog(BuildContext context) async {

  final translocations = Translations.of(context);
  // showDialogの戻り値をawaitして、結果をresultに格納する
  bool? result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,  // ダイアログ外をタップしても閉じないようにする
    builder: (BuildContext context) => AlertDialog(
      title: Text(translocations.import_export.back_up_confirm_dialog.title),
      content: Text(
        translocations.import_export.back_up_confirm_dialog.text,
        style: TextStyle(fontSize: 16),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),  // いいえを押したときにfalseを返す
          child: Text(translocations.import_export.back_up_confirm_dialog.no),
        ),
        
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),  // はいを押したときにtrueを返す
          child: Text(translocations.import_export.back_up_confirm_dialog.yes),
        ),
        
      ],
    ),
  );

  return result ?? false;  // showDialogがnullを返す場合はfalseとする
}













/*
const List<String> importHelpContents = [
  'インポートを行うと、現在のデータベースが上書きされます。\n\nインポート前に確認を行ってください。',
  '表示されるサムネイルは端末の画像があるパスを参照しています。\n\n端末を変えたり、画像を端末から削除してしまうとサムネイルが表示できなくなります。',
];
 */





void showImportHelpDialog(BuildContext context) {
  final translations = Translations.of(context);

  List<String> importHelpContents = [
    translations.import_export.import_dialog.page_1.text,
    translations.import_export.import_dialog.page_2.text,
  ];
  showDialog(
    context: context,
    builder: (context) {
      final PageController pageController = PageController(initialPage: 0);
      final List<Widget> pages = [
        HelpPage(content: importHelpContents[0], title: translations.import_export.import_dialog.page_1.title),
        HelpPage(content: importHelpContents[1], title: translations.import_export.import_dialog.page_2.title),
      ];
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0), // 角を丸くする
        ),
        child: Container(
          height: SizeConfig.blockSizeVertical! * 60,  // 高さを適切に設定
          width: SizeConfig.blockSizeHorizontal! * 80,  // 幅を適切に設定
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: pages,
                ),
              ),
              SizedBox(height: 10,),
              SmoothPageIndicator(
                controller: pageController,
                count: pages.length,
                effect: WormEffect(),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      );
    },
  );
}
