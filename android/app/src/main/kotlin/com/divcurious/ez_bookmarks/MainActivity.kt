package com.divcurious.ez_bookmarks

import android.content.Context
import android.view.LayoutInflater
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // 既存のFactoryを登録
        val listTileFactory = ListTileNativeAdFactory(context)
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTile", listTileFactory)

        val gridNativeLightFactory = GridNativeAdLightFactory(context)
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "gridLight", gridNativeLightFactory)

        val gridNativeDarkFactory = GridNativeAdDarkFactory(context)
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "gridDark", gridNativeDarkFactory)

        /*
        val listTileFactory_2 = ListTileNativeAdFactory_2(context)
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTile_2", listTileFactory)

        val listTileFactory_3 = ListTileNativeAdFactory_3(context)
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTile_3", listTileFactory)

        val listTileFactory_4 = ListTileNativeAdFactory_4(context)
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTile_4", listTileFactory)

        val listTileFactory_5 = ListTileNativeAdFactory_5(context)
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTile_5", listTileFactory)

        val listTileFactory_6 = ListTileNativeAdFactory_6(context)
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTile_6", listTileFactory)

         */
        /*
        // 新しいNativeAdFactoryExampleを登録
        val layoutInflater = LayoutInflater.from(context)
        val gridAdFactory = GridAdFactory(layoutInflater)
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "gridAd", gridAdFactory)
         */
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
        
        // Factoryを登録解除
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "gridLight")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "gridDark")
        /*
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile_2")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile_3")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile_4")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile_5")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile_6")
         */
    }
}
