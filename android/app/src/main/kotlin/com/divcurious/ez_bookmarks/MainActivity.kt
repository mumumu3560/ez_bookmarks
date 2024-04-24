/*
package com.divcurious.ez_bookmarks

import io.flutter.embedding.android.FlutterActivity
class MainActivity: FlutterActivity()


 */

/*


 */


package com.divcurious.ez_bookmarks

import io.flutter.embedding.android.FlutterActivity

// COMPLETE: Import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngine

// COMPLETE: Import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        GoogleMobileAdsPlugin.registerNativeAdFactory(
                flutterEngine, "listTile", ListTileNativeAdFactory(context))
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)

        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile")
    }
}






/*


 */




