import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'db_switcher.g.dart';

@riverpod
class DbSwitcherNotifier extends _$DbSwitcherNotifier{

  @override
  String build() {
    //最初はez_databaseを返す。
    String db = "ez_database";
    return db;
  }

  //ここでdb変更。
  //ez_database、ez_database_1、ez_database_2のいずれかを引数に取る。
  void updateState(String db) {
    print("変更前のstate: $state");
    state = db;
    print("変更後のstate: $state");
  }


}