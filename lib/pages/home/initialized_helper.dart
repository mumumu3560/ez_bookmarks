import 'package:async_preferences/async_preferences.dart';
import 'package:ez_bookmarks/riverpod/gdpr/consent/gdpr_consent.dart';
import 'package:ez_bookmarks/riverpod/gdpr/judge_in_gdpr/gdpr_jud.dart';
import 'package:ez_bookmarks/riverpod/interstitial/interstitial_ad_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


//GDPR専用の初期化クラス
class InitializedHelper{



  Future<void> initialize(WidgetRef ref) async{


    

    // TODO GDPRの同意メッセージの表示
    final params = ConsentRequestParameters();



    ConsentInformation.instance.requestConsentInfoUpdate(
      params,
      () async {
        if (await ConsentInformation.instance.isConsentFormAvailable()) {
          loadForm(ref);
          loadGdpr(ref);
        }
        else{
          loadGdpr(ref);
        }
      },
      (FormError error) {

      },
    );

    



  }



  //gdprの同意を取る
  Future<void> loadForm(WidgetRef ref) async{

    ConsentForm.loadConsentForm(
      (ConsentForm consentForm) async {
        var status = await ConsentInformation.instance.getConsentStatus();
        //同意が必要な場合は、同意フォームを表示
        if (status == ConsentStatus.required) {
          consentForm.show(
            (formError) {
              //なんでここで二重に呼び出すかというと
              //ここに入った時点ではまだ同意が取れていないのでもう一度呼び出すことで、
              //status == ConsentStatus.requiredの判定を行う必要があるから

              loadForm(ref);
            },
          );
        }
        else{
          //ここでは同意が必要ない場合の処理を行う
          //(つまり同意が取れている場合やGDPR対象国でない場合の処理を行う)
          //なぜかGDPR対象国でないはずなのに同意が取れていない場合があるので、
          //loadGdpr()において、GDPR対象国かどうかを判定する。

          await initializeAds(ref);

          //2秒待つ
          await Future.delayed(const Duration(seconds: 2));

          final consentNotifier = ref.read(gdprConsentNotifierProvider.notifier);
          consentNotifier.updateState(true);


        }
      },
      (formError) {
      },
    );
  }

  
  //gdpr対象国かどうかを判定
  //https://toconakis.tech/flutter-admob-gdpr/
  Future<void> loadGdpr(WidgetRef ref)async{
    // IABTCF_gdprAppliesが 1 であるかどうかをチェック
    final preferences = AsyncPreferences();
    bool judge = await preferences.getInt('IABTCF_gdprApplies') == 1;

    if(judge == false){
      await initializeAds(ref);
    }


    final gdprJudgeNotifier = ref.read(gdprJudgeNotifierProvider.notifier);
    gdprJudgeNotifier.updateState(judge);



  }


  //mobile adsの初期化
  Future<void> initializeAds(WidgetRef ref) async {
    await MobileAds.instance.initialize();

    final interstitialNotifier = ref.read(interstitialAdNotifierProvider.notifier);
    interstitialNotifier.loadAd();

  }
    
}