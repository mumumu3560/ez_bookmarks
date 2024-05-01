import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_switcher.g.dart';

@riverpod
class ThemeModeSwitcherNotifier extends _$ThemeModeSwitcherNotifier{

  @override
  Future<int> build() async{
    //final dbAdmin = ref.watch(dbAdminNotifierProvider);
    final dbAdmin = ref.read(dbAdminNotifierProvider);
    //databaseが初期化されていない場合は、ライトモードを返す。
    //int themeId = await myDatabase.getTheme();
    int? themeId = await dbAdmin.getTheme();

    if(themeId == null){
      //await myDatabase.insertTheme();
      await dbAdmin.insertTheme();
      return 1;
    }

    return themeId;
  }

  //ここでthemeModeを変更する。
  Future<void> updateState(int themeId) async{
    state = AsyncValue.data(themeId);

    final dbAdmin = ref.watch(dbAdminNotifierProvider);

    await dbAdmin.updateTheme(themeId);
  }

  


}