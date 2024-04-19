import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'desc_or_asc_switcher.g.dart';

@riverpod
class DescOrAscSwitcherNotifier extends _$DescOrAscSwitcherNotifier{

  @override
  bool build() {
    //最初は降順で返す。
    bool isDesc = true;
    return isDesc;
  }

  //ここでDescOrAscを変更する。
  void updateState(bool isDesc) {
    state = isDesc;
  }


}