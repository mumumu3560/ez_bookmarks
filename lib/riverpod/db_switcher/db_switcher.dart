import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'db_switcher.g.dart';

@riverpod
class DbSwitcherNotifier extends _$DbSwitcherNotifier{

  @override
  String build() {
    //最初はclassifier_databaseを返す。
    String db = "classifier_database1";
    return db;
  }

  //ここでdb変更。
  //classifier_database、classifier_database_1、classifier_database_2のいずれかを引数に取る。
  void updateState(String db) {
    state = db;
  }


}