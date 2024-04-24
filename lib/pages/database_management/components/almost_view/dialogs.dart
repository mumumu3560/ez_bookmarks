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







const List<String> backupHelpContents = [
  'バックアップファイルは\nclassifier_database_backup\n(1,2,3).sqlite\nという名前でダウンロードフォルダに保存されます。\n',
  'すでにバックアップファイルが存在する場合、上書きされます。\n\nバックアップ前に確認を行ってください。',
];

void showBackupHelpDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      final PageController pageController = PageController(initialPage: 0);
      final List<Widget> pages = [
        HelpPage(content: backupHelpContents[0], title: "ファイル名"),
        HelpPage(content: backupHelpContents[1], title: "注意"),
      ];
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0), // 角を丸くする
        ),
        child: Container(
          height: SizeConfig.blockSizeVertical! * 50,  // 高さを適切に設定
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


























const List<String> importHelpContents = [
  'インポートを行うと、現在のデータベースが上書きされます。\n\nインポート前に確認を行ってください。',
  '表示されるサムネイルは端末の画像があるパスを参照しています。\n\n端末を変えたり、画像を端末から削除してしまうとサムネイルが表示できなくなります。',
];

void showImportHelpDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      final PageController pageController = PageController(initialPage: 0);
      final List<Widget> pages = [
        HelpPage(content: importHelpContents[0], title: "上書き"),
        HelpPage(content: importHelpContents[1], title: "サムネイル"),
      ];
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0), // 角を丸くする
        ),
        child: Container(
          height: SizeConfig.blockSizeVertical! * 50,  // 高さを適切に設定
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
