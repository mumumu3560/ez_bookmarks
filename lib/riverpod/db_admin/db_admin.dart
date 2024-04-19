
import 'package:ez_bookmarks/drift/database_1/database.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'db_admin.g.dart';

@riverpod
class DbAdminNotifier extends _$DbAdminNotifier{

  @override
  MyDatabase build() {
    String db = "ez_database";
    MyDatabase myDB = MyDatabase(dbName: db);
    return myDB;
  }

  //ここでdb変更。
  //ez_database、ez_database_1、ez_database_2のいずれかを引数に取る。
  Future<void> updateDB(String db) async{
    //myDatabaseをいったん破棄して、新しいdbを作成する。
    state = MyDatabase(dbName: db);
  }

  Future<void> closeDB() async{
    await state.close();
  }

  




}