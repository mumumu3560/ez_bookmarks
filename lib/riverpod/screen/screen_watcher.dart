import 'package:ez_bookmarks/utils/various.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen_watcher.g.dart';

@riverpod
class ScreenWatcherNotifier extends _$ScreenWatcherNotifier{

  @override
  double build() {
    final screenWidth = SizeConfig.screenWidth!;

    return screenWidth;

  }

  //ここでthemeModeを変更する。
  void updateState(double screenWidth) {

    state = screenWidth;
  }


}