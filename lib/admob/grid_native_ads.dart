import 'package:ez_bookmarks/env/env.dart';
import 'package:ez_bookmarks/riverpod/theme/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';



/*
class GridNativeAdWidget extends ConsumerStatefulWidget {
  final double height;
  final double width;

  const GridNativeAdWidget({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  _GridNativeAdWidgetState createState() => _GridNativeAdWidgetState();
}

class _GridNativeAdWidgetState extends ConsumerState<GridNativeAdWidget> {

  @override
  Widget build(BuildContext context) {

    return Container();
  }


}
 */
















class GridNativeAdWidget extends ConsumerStatefulWidget {
  final double height;
  final double width;

  const GridNativeAdWidget({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  _GridNativeAdWidgetState createState() => _GridNativeAdWidgetState();
}

class _GridNativeAdWidgetState extends ConsumerState<GridNativeAdWidget> {
  NativeAd? _nativeAd;
  bool _isAdLoaded = false;

  Future<void> _loadNativeAd(WidgetRef ref) async{
    //ここでテーマモードのintを取得したい。
    final themeInt = ref.read(themeModeSwitcherNotifierProvider);

    String factoryIdNow =  themeInt == const AsyncValue.data(0) ? 'gridLight' : 'gridDark';


    //final ref = themeInt == 0 ? Env.n1 : Env.n2;
    _nativeAd = NativeAd(
      adUnitId: Env.n1,  // 広告ユニットID、自分はenviedを使っている
      factoryId: factoryIdNow,  // MainActivity.ktで指定したfactoryId
      //factoryId: 'listTile',  // MainActivity.ktで指定したfactoryId
      nativeAdOptions: NativeAdOptions(
        mediaAspectRatio: MediaAspectRatio.any,
      ),

      /*
      nativeTemplateStyle: NativeTemplateStyle(
            // Required: Choose a template.
            templateType: TemplateType.medium,
            // Optional: Customize the ad's style.
            mainBackgroundColor: Colors.purple,
            cornerRadius: 10.0,
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.cyan,
                backgroundColor: Colors.red,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.red,
                backgroundColor: Colors.cyan,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.green,
                backgroundColor: Colors.black,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.brown,
                backgroundColor: Colors.amber,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)),
       */

      listener: NativeAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
      
       
    );

    _nativeAd!.load();
  }

  @override
  void initState() {
    super.initState();
    _loadNativeAd(ref);
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: _isAdLoaded ? AdWidget(ad: _nativeAd!) : Container(),
    );
  }
}




















/*

 */