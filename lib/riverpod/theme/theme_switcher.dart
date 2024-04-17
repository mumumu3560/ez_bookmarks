import 'package:ez_bookmarks/utils/various.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_switcher.g.dart';

@riverpod
class ThemeModeSwitcherNotifier extends _$ThemeModeSwitcherNotifier{

  @override
  Future<int> build() async{
    //databaseが初期化されていない場合は、ライトモードを返す。
    int themeId = await myDatabase.getTheme();
    return themeId;
  }

  //ここでthemeModeを変更する。
  Future<void> updateState(int themeId) async{
    print('themeId: $themeId');
    print('state: $state');
    state = AsyncValue.data(themeId);
  }


}