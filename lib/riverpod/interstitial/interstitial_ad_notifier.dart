
import 'package:ez_bookmarks/env/env.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interstitial_ad_notifier.g.dart'; // 自動生成ファイル


//ここでkeepAliveを設定しないと、watchしていない状態でdisposeされてしまう
@Riverpod(keepAlive: true)
class InterstitialAdNotifier extends _$InterstitialAdNotifier {

  final adUnitId = Env.i1;
  @override
  InterstitialAd? build() {

    return null;
  }

  void loadAd() {
    if (state == null) { // 広告がまだロードされていない場合
      InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),

        adLoadCallback: InterstitialAdLoadCallback(

          onAdLoaded: (InterstitialAd ad) {
            state = ad;
            _setCallbacks(ad); // コールバックを設定
          },

          onAdFailedToLoad: (LoadAdError error) {
            
            state = null; // エラーが発生したため、stateをnullに設定
          },

        ),
      );
    }
  }

  Future<void> showAd() async {
    if(state == null) return; // 広告がロードされていない場合は何もしない
    state!.show();
  }

  void _setCallbacks(InterstitialAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {

        

        ad.dispose();
        state = null; // 広告を表示後にnullに設定
        loadAd(); // 広告を再ロードする（オプション）
        

      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {

        ad.dispose();
        state = null; // 広告を表示後にnullに設定

      },
    );
  }

  void disposeAd() {
    if(state != null) {
      state!.dispose();
      state = null;
    }
  }
}