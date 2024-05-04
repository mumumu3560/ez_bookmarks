import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interstitial_count_notifier.g.dart'; // 自動生成ファイル

//keepAliveをtrueにすることで、画面遷移しても状態を保持する
@Riverpod(keepAlive: true)
class InterstitialCountNotifier extends _$InterstitialCountNotifier {

  @override
  int build(){
    return 0;
  }

  void updateState() {
    print("interstitialPrevious: $state"); // 0 (初期値
    final int nowCount = state;
    state = nowCount + 1;
    print("interstitialNext: $state"); // 0 (初期値

  }


}
