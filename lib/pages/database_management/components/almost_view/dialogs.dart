import 'package:flutter/material.dart';

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

  void showBackupHelpDialog(BuildContext context){


    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text('注意'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'バックアップファイルはezb_backup.sqliteという名前でダウンロードフォルダに保存されます。\n',
              style: TextStyle(fontSize: 16),
            ),
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