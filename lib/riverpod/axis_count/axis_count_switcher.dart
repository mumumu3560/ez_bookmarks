import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'axis_count_switcher.g.dart';

@riverpod
class AxisCountSwitcherNotifier extends _$AxisCountSwitcherNotifier{


  @override
  Future<int> build() async{
    final dbAdmin = ref.watch(dbAdminNotifierProvider);
    //databaseが初期化されていない場合は、ライトモードを返す。
    //int axisCount = await myDatabase.getAxisCount();
    int axisCount = await dbAdmin.getAxisCount();

    return axisCount;
  }

  //ここでthemeModeを変更する。
  Future<void> updateState(int axisCount) async{

    state = AsyncValue.data(axisCount);
  }


}