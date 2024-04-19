import 'dart:io';
import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:ez_bookmarks/riverpod/db_switcher/db_switcher.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ez_bookmarks/drift/database_1/database.dart'; // 正しいパスに修正してください

import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path/path.dart' as p;

import 'package:external_path/external_path.dart';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';


Future<void> backupDatabase(WidgetRef ref, BuildContext context, String dbName) async {
    String? path;

    if(Platform.isWindows){
      path = await FilePicker.platform.saveFile(
        dialogTitle: 'バックアップを保存する場所を選択してください',
        fileName: '${dbName}_backup.sqlite',
        bytes: Uint8List(0),
      );
    }

    if(Platform.isAndroid){

      path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
      //path = p.join(path, 'ezb_backup.sqlite');
      path = p.join(path, '${dbName}_backup.sqlite');

    }


    if (path != null) {
      final File file = File(path);

      if ((await file.exists())) {
        if(!context.mounted){
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

      final dbAd = ref.watch(dbAdminNotifierProvider);

      // データベースのバックアップを新しいファイルに作成
      //await myDatabase.backupDatabase(path);

      await dbAd.backupDatabase(path);


      if(context.mounted){
        context.showSuccessSnackBar(message: 'データベースがバックアップされました');
      }
    }
  }


  // データベースのインポート
  //dbNameで指定されたデータベースにインポートする
  Future<void> importDatabase(WidgetRef ref,  BuildContext context,  String dbName) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      final String path = result.files.single.path!;
      //await myDatabase.importDatabase(path, dbName);

      //final dbAd = ref.read(dbAdminNotifierProvider);
      final dbAdNotifier = ref.read(dbAdminNotifierProvider.notifier);

      final dbName = ref.read(dbSwitcherNotifierProvider);

      final nowDbName = dbName;



      //await myDatabase.close(); // 最初にデータベース接続を閉じる
      await dbAdNotifier.closeDB();

      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, '$dbName.sqlite'));

      await file.delete();
      await File(path).copy(file.path);

      //myDatabase = MyDatabase(dbName: dbName); // データベースを再作成
      await dbAdNotifier.updateDB(nowDbName);

      if(context.mounted){
        context.showSuccessSnackBar(message: 'データベースがインポートされました');
      }
      // 必要に応じてアプリケーションの再起動やデータベースの再読み込みする
    }
  }






  /*
  
  // 新しいデータベースファイルで現在のデータベースを置き換える
  Future<void> importDatabase(String newPath, String dbName) async {

    await myDatabase.close(); // 最初にデータベース接続を閉じる
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, '$dbName.sqlite'));

    await file.delete();
    await File(newPath).copy(file.path);
    // データベースの再接続や初期化が必要な場合はここで実行
  }
   */