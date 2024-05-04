import 'package:ez_bookmarks/admob/inline_adaptive_banner.dart';
import 'package:ez_bookmarks/env/env.dart';
import 'package:ez_bookmarks/i18n/strings.g.dart';
import 'package:ez_bookmarks/pages/bookmark_list/bookmark_list_page.dart';
import 'package:ez_bookmarks/pages/setting/components/almost_logic/almost_logic.dart';
import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:ez_bookmarks/riverpod/db_switcher/db_switcher.dart';
import 'package:ez_bookmarks/riverpod/interstitial/count/interstitial_count_notifier.dart';
import 'package:ez_bookmarks/riverpod/interstitial/interstitial_ad_notifier.dart';
import 'package:ez_bookmarks/riverpod/local/language.dart';
import 'package:ez_bookmarks/riverpod/theme/theme_switcher.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';




class LanguagePage extends ConsumerWidget {
  const LanguagePage({super.key});



  static final String adUnitId = Env.i1;

  

  @override
  Widget build(BuildContext context, WidgetRef ref){


    final dbAdmin = ref.watch(dbAdminNotifierProvider);

    final translations = Translations.of(context);
    final languageState = ref.watch(languageNotifierProvider);

    final languageNotifier = ref.read(languageNotifierProvider.notifier);


    return Scaffold(
      appBar: AppBar(
        title: Text(translations.settings.language),
      ),

      //ListTileのリストを作成
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: AppLocale.values.length,
              itemBuilder: (context, index) {
                final locale = AppLocale.values[index];
                return RadioListTile<AppLocale>(
                  value: locale,
                  groupValue: languageState,
                  title: Text(translations.locales[locale.languageTag]!),
                  onChanged: (value) {
                    if (value != null) {
                      languageNotifier.updateLocale(value);
                    }
                  },
                );
              },
            ),
          ),
          
        

          SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
      
          Container(
            height: SizeConfig.blockSizeVertical! * 10,
            color: Colors.white,
            //TODO Admob
            child: InlineAdaptiveAdBanner(
              requestId: "SETTING", 
              adHeight: SizeConfig.blockSizeVertical!.toInt() * 10,
            ),
          ),

          SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
          
        ],
      )

    );
  }
}
