import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:ez_bookmarks/env/env.dart';


/*






class AdaptiveAdBanner extends StatelessWidget{
  final String requestId;

  const AdaptiveAdBanner({
    super.key,
    required this.requestId,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }


}
 */








class AdaptiveAdBanner extends StatelessWidget {

  final String requestId;
  const AdaptiveAdBanner({
    Key? key,
    this.onLoaded,
    required this.requestId,
  }): super(key: key);

  static Map<String, String> adUnits = {

    "BOOKMARK": Env.b1,
    "ADD": Env.b2,
    "EDIT": Env.b3,
    "TAG": Env.b4,
    "IMPORT": Env.b5,
    "SETTING": Env.b6,
  };

  final VoidCallback? onLoaded;

  @override
  Widget build(BuildContext context) {
    final adUnitId = adUnits[requestId];
    return LayoutBuilder(builder: (context, constraint) {
      return HookBuilder(builder: (context) {
        final bannerLoaded = useState(false);
        final bannerAd = useFuture(
          useMemoized(
            () async {
              final adWidth = constraint.maxWidth.truncate();
              final adSize = await AdSize.getAnchoredAdaptiveBannerAdSize(
                MediaQuery.of(context).orientation,
                adWidth,
              ) as AdSize;

              return BannerAd(
                size: adSize,
                adUnitId: adUnitId!,
                listener: BannerAdListener(
                  onAdFailedToLoad: (ad, error) {
                    ad.dispose();
                    bannerLoaded.value = false;
                  },
                  onAdLoaded: (ad) {
                    bannerLoaded.value = true;
                    onLoaded?.call();
                  },
                ),
                request: const AdRequest(),
              );
            },
          ),
        ).data;

        if (bannerAd == null) {
          return const SizedBox.shrink();
        }

        useEffect(() {
          bannerAd.load();
          return () async => await bannerAd.dispose();
        }, [bannerAd]);

        return bannerLoaded.value
            ? SizedBox(
                width: bannerAd.size.width.toDouble(),
                height: bannerAd.size.height.toDouble(),
                child: AdWidget(ad: bannerAd),
              )
            : const SizedBox.shrink();
      });
    });
  }
}
























/*









 */




