import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sort_kind_switcher.g.dart';

@riverpod
class SortKindSwitcherNotifier extends _$SortKindSwitcherNotifier{

  @override
  String build() {
    //databaseが初期化されていない場合は、ライトモードを返す。
    String sortKind = "createdAt";
    return sortKind;
  }

  //ここでSortKindを変更する。
  void updateState(String sortKind) {

    state = sortKind;
  }


}