
import 'package:ez_bookmarks/drift/database_1/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'db_admin.g.dart';

@riverpod
class DbAdminNotifier extends _$DbAdminNotifier{

  @override
  MyDatabase build() {
    //最初はez_databaseを返す。
    //もしくはshared_preferencesから取得する。
    String db = "ez_database";
    MyDatabase myDB = MyDatabase(dbName: db);
    return myDB;
  }

  //ここでdb変更。
  //ez_database、ez_database_1、ez_database_2のいずれかを引数に取る。
  Future<void> updateDB(String db) async{
    //myDatabaseをいったん破棄して、新しいdbを作成する。
    await state.close();
    state = MyDatabase(dbName: db);
  }

  //ここでテーマ変更。
  Future<void> updateTheme(int themeId) async{
    state.updateTheme(themeId);
  }

  Future<int> getTheme(){
    return state.getTheme();
  }

  




}