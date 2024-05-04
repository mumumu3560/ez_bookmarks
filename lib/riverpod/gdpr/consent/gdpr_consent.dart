import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gdpr_consent.g.dart';

@Riverpod(keepAlive: true)
class GdprConsentNotifier extends _$GdprConsentNotifier{

  @override
  Future<bool> build() async{
    var status = await ConsentInformation.instance.getConsentStatus();
    if(status == ConsentStatus.obtained){
      return true;
    }
    //最初は降順で返す。
    return false;
  }

  //ここでDescOrAscを変更する。
  void updateState(bool jud) {
    state = AsyncValue.data(jud);
  }


}