import 'dart:io';

import 'package:ez_bookmarks/admob/inline_adaptive_banner.dart';
import 'package:ez_bookmarks/pages/database_management/components/almost_view/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ez_bookmarks/drift/database_1/database.dart'; // 正しいパスに修正してください

import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path/path.dart' as p;

import 'package:external_path/external_path.dart';
import 'dart:typed_data';

class DatabaseManagementPage extends StatefulWidget {
  const DatabaseManagementPage({super.key});

  @override
  _DatabaseManagementPageState createState() => _DatabaseManagementPageState();
}

class _DatabaseManagementPageState extends State<DatabaseManagementPage> {
  //late MyDatabase db;

  @override
  void initState() {
    super.initState();
    //db = myDatabase;
  }

  Future<void> backupDatabase() async {
    String? path;

    if(Platform.isWindows){
      path = await FilePicker.platform.saveFile(
        dialogTitle: 'バックアップを保存する場所を選択してください',
        fileName: 'ezb_backup.sqlite',
        bytes: Uint8List(0),
      );
    }

    if(Platform.isAndroid){

      path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
      path = p.join(path, 'ezb_backup.sqlite');

    }


    if (path != null) {
      final File file = File(path);

      if ((await file.exists())) {
        if(!mounted){
          return;
        }
        final bool shouldOverwrite = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('確認'),
            content: Text('ファイル "$path" は既に存在します。上書きしますか？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('キャンセル'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('上書き'),
              ),
            ],
          ),
        ) ?? false;

        if (!shouldOverwrite) {
          return;
        }
        await file.delete();

      }

      // データベースのバックアップを新しいファイルに作成
      await myDatabase.backupDatabase(path);


      if(mounted){
        context.showSuccessSnackBar(message: 'データベースがバックアップされました');
      }
    }
  }



  Future<void> importDatabase(String dbName) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      final String path = result.files.single.path!;
      await myDatabase.importDatabase(path);

      myDatabase = MyDatabase(dbName: dbName); // データベースを再作成

      if(mounted){
        context.showSuccessSnackBar(message: 'データベースがインポートされました');
      }
      // 必要に応じてアプリケーションの再起動やデータベースの再読み込みする
    }
  }

 @override
Widget build(BuildContext context) {

  //ここでdbNameをriverpodから取得
  //final dbName = 

  return Scaffold(
    appBar: AppBar(
      title: const Text('データベース管理'),
    ),
    body: Column(
      children: [
        Expanded(
          child: SafeArea(
            child: SingleChildScrollView( // Allows the page to be scrollable
              padding: const EdgeInsets.all(20.0), // Adds padding around the content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Aligns text to the start of the app
                children: <Widget>[

                  
                  Row(
                    children: [
                      Text(
                        'インポートについて',
                        style: Theme.of(context).textTheme.titleLarge
                      ),
            
                      IconButton(
                        onPressed: () => showImportHelpDialog(context),
                        icon: const Icon(Icons.help)
                      )
                    ],
                  ),
            
                  ElevatedButton(
                    onPressed: () => importDatabase("ez_database.db"), 
                    child: const Text("インポートする")
                  ),
            
            
                  Row(
                    children: [
                      Text(
                        'バックアップについて',
                        style: Theme.of(context).textTheme.titleLarge
                      ),
                      IconButton(
                        onPressed: () async{
                          showBackupHelpDialog(context);
                        } , 
                        icon: const Icon(Icons.help)
                      )
                    ],
                  ),
            
                  ElevatedButton(
                    onPressed: backupDatabase, 
                    child: const Text("バックアップする")
                  ),
            
                ],
              ),
            ),
          ),
        ),
      
        SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
        
          Container(
            height: SizeConfig.blockSizeVertical! * 10,
            color: Colors.white,
            //TODO Admob
            child: InlineAdaptiveAdBanner(
              requestId: "IMPORT", 
              adHeight: SizeConfig.blockSizeVertical!.toInt() * 10,
            ),

            /*
            
            */
          ),

          SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
      ],
    ),
  );
}

}
