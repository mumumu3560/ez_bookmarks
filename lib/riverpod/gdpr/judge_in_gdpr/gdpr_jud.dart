import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gdpr_jud.g.dart';

@Riverpod(keepAlive: true)
class GdprJudgeNotifier extends _$GdprJudgeNotifier{

  @override
  bool build() {
    return true;
  }

  //ここでDescOrAscを変更する。
  void updateState(bool jud) {
    state = jud;
  }


}

