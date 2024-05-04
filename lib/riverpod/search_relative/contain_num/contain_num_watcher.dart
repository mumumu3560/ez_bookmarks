import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contain_num_watcher.g.dart';

@riverpod
class ContainNumWatcherNotifier extends _$ContainNumWatcherNotifier{

  @override
  int build() {

    return 0;
  }

  void updateState(int value) {
    state = value;
  }

  


}