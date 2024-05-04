import 'dart:io';
import 'package:ez_bookmarks/i18n/strings.g.dart';
import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:ez_bookmarks/riverpod/db_switcher/db_switcher.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path/path.dart' as p;

import 'package:external_path/external_path.dart';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';









Future<String> generateSequentialBackupFileName(String basePath, String dbName) async {
  int index = 1;
  while (true) {
    String fileName = p.join(basePath, '${dbName}_backup${index}.sqlite');
    if (!await File(fileName).exists()) {
      return fileName; // 存在しないファイル名が見つかったらそれを返す
    }
    index++;
  }
}




Future<void> backupDatabase(WidgetRef ref, BuildContext context, String dbName) async {
    String? path;

    if(!context.mounted) return;
    final translocations = Translations.of(context);

    if(Platform.isWindows){
      path = await FilePicker.platform.saveFile(
        dialogTitle: 'バックアップを保存する場所を選択してください',
        fileName: '${dbName}_backup.sqlite',
        bytes: Uint8List(0),
      );
    }

    if(Platform.isAndroid){
      final String basePath = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
      path = await generateSequentialBackupFileName(basePath, dbName);
    }

    if(path == null){
      return;
    }


    final File file = File(path);
    await file.create(recursive: true); // ファイル作成

      final dbAd = ref.read(dbAdminNotifierProvider);

      await dbAd.backupDatabase(path);


      if(context.mounted){
        context.showSuccessSnackBar(message: '${translocations.import_export.on_backup.complete} $file');
      }
    }












Future<String> generateTimestampBackupFileName(String basePath, String dbName) async {
  String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
  return p.join(basePath, '${dbName}_backup_$timestamp.sqlite');
}

Future<void> backupDatabaseWithTimestamp(BuildContext context, WidgetRef ref, String dbName) async {
  final String basePath = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
  final String path = await generateTimestampBackupFileName(basePath, dbName);

  if(!context.mounted) return;

  final translocations = Translations.of(context);

  final File file = File(path);
  await file.create(recursive: true); // ファイル作成

  final dbAd = ref.read(dbAdminNotifierProvider);
  await dbAd.backupDatabase(path);

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${translocations.import_export.on_backup.complete}: $path')));
  }
}
  










  









  // データベースのインポート
  //dbNameで指定されたデータベースにインポートする
  Future<void> importDatabase(WidgetRef ref,  BuildContext context,  String dbName) async {

    final translocations = Translations.of(context);

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
        context.showSuccessSnackBar(message: '${translocations.import_export.on_import.complete}');
      }
      // 必要に応じてアプリケーションの再起動やデータベースの再読み込みする
    }
  }