import 'package:ez_bookmarks/utils/various.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'aspect_switcher.g.dart';

@riverpod
class AspectSwitcherNotifier extends _$AspectSwitcherNotifier{

  @override
  Future<double> build() async{
    double aspect = await myDatabase.getAspectRatio();

    return aspect;
  }

  //ここでthemeModeを変更する。
  Future<void> updateState(double aspectRatio) async{

    state = AsyncValue.data(aspectRatio);
  }


}