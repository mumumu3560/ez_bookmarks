
import 'package:ez_bookmarks/database/drift/database_1/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'db_admin.g.dart';

@riverpod
class DbAdminNotifier extends _$DbAdminNotifier{

  @override
  MyDatabase build() {
    String db = "classifier_database_1";
    MyDatabase myDB = MyDatabase(dbName: db);
    return myDB;
  }

  //ここでdb変更。
  //classifier_database、classifier_database_1、classifier_database_2のいずれかを引数に取る。
  Future<void> updateDB(String db) async{
    //myDatabaseをいったん破棄して、新しいdbを作成する。
    state = MyDatabase(dbName: db);
  }

  Future<void> closeDB() async{
    await state.close();
  }

  




}