import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'desc_or_asc_switcher.g.dart';

@riverpod
class DescOrAscSwitcherNotifier extends _$DescOrAscSwitcherNotifier{

  @override
  bool build() {
    //databaseが初期化されていない場合は、ライトモードを返す。
    bool isDesc = true;
    return isDesc;
  }

  //ここでDescOrAscを変更する。
  void updateState(bool isDesc) {
    state = isDesc;
  }


}