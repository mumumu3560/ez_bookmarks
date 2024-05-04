import 'package:ez_bookmarks/admob/inline_adaptive_banner.dart';
import 'package:ez_bookmarks/env/env.dart';
import 'package:ez_bookmarks/i18n/strings.g.dart';
import 'package:ez_bookmarks/pages/bookmark_list/bookmark_list_page.dart';
import 'package:ez_bookmarks/pages/setting/components/almost_logic/almost_logic.dart';
import 'package:ez_bookmarks/pages/setting/components/language_page/language_page.dart';
import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:ez_bookmarks/riverpod/db_switcher/db_switcher.dart';
import 'package:ez_bookmarks/riverpod/gdpr/judge_in_gdpr/gdpr_jud.dart';
import 'package:ez_bookmarks/riverpod/interstitial/count/interstitial_count_notifier.dart';
import 'package:ez_bookmarks/riverpod/interstitial/interstitial_ad_notifier.dart';
import 'package:ez_bookmarks/riverpod/local/language.dart';
import 'package:ez_bookmarks/riverpod/theme/theme_switcher.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

//GDPR
import 'package:async_preferences/async_preferences.dart';



class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  static Map<int,String> dbMap = {
    0: "classifier_database1",
    1: "classifier_database2",
    2: "classifier_database3",
  };

  static Map<String, String> dbNameMap = {
    "classifier_database1": "DB1",
    "classifier_database2": "DB2",
    "classifier_database3": "DB3",
  };

  static Map<String, int> dbReMap = {
    "classifier_database1": 0,
    "classifier_database2": 1,
    "classifier_database3": 2,
  };

  static final String adUnitId = Env.i1;


  

  @override
  Widget build(BuildContext context, WidgetRef ref){

    final interstitial = ref.watch(interstitialAdNotifierProvider);

    final nowTheme = ref.watch(themeModeSwitcherNotifierProvider);

    final dbName = ref.watch(dbSwitcherNotifierProvider);

    final interstitialCount = ref.watch(interstitialCountNotifierProvider); 
    final dbAdmin = ref.watch(dbAdminNotifierProvider);

    final translations = Translations.of(context);

    final gdpr = ref.watch(gdprJudgeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(translations.settings.title),
      ),

      //ListTileのリストを作成
      body: Column(
        children: [
          Expanded(
            child: (interstitial == null && interstitialCount % 3 == 0)
              ? const Center(child: CircularProgressIndicator())
              : Column(
              children: [
                
                ListTile(
                  title: Text(translations.settings.privacy_policy),
                  onTap: () async{

                    final url = Uri.parse(translations.external_url.privacy_policy);

                    if( await canLaunchUrl(url)){
                      await launchUrl(url);
                    }
            
                    
            
                  }
                ),

                //ここにGDPRの同意画面を表示する
                gdpr == true
                ? ListTile(
                  title: Text("GDPR"),
                  onTap: () async {

                    await changePrivacyPreferences();

                  },
                )
                : Container(),

                ListTile(
                  title: Row(
                    children: [
                      Text(translations.settings.change_theme),
                      nowTheme.when(
                        data: (data) => IconButton(
                          onPressed: () async{

                            int? thisTheme = await dbAdmin.getTheme();
                            final themeNotifier = ref.read(themeModeSwitcherNotifierProvider.notifier);
                            
                            if (thisTheme == 0) {
                              await themeNotifier.updateState(1);
                              await dbAdmin.updateTheme(1);

                            } else if(thisTheme == 1){
                              await themeNotifier.updateState(0);
                              await dbAdmin.updateTheme(0);
                            }
                            else{
                              await dbAdmin.insertTheme();

                              await themeNotifier.updateState(1);
                              await dbAdmin.updateTheme(1);
                            }


                            


                          }, 
                          icon: data == 0 ? const Icon(Icons.light_mode) : const Icon(Icons.dark_mode),
                        ),
                        error: (error, stackTrace) => const Text('error'),
                        loading: () => const CircularProgressIndicator(),
                      ),
                    ],
                  ),
                  onTap: () async {
            
                    int? thisTheme = await dbAdmin.getTheme();
                    final themeNotifier = ref.read(themeModeSwitcherNotifierProvider.notifier);
                    
            
                    if (thisTheme == 0) {
                      themeNotifier.updateState(1);
                      dbAdmin.updateTheme(1);

                    } else if(thisTheme == 1){
                      themeNotifier.updateState(0);
                      dbAdmin.updateTheme(0);
                    }
                    else{
                      dbAdmin.insertTheme();
                      themeNotifier.updateState(1);
                      dbAdmin.updateTheme(1);
                    }






                  },
                ),

                ListTile(
                  //言語切り替え
                  title: Text(translations.settings.language),
                  onTap: () async {

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LanguagePage(), // ImageDisplayに遷移
                      ),
                    );
                    
                    
                    /*
                    final languageNotifier = ref.read(languageNotifierProvider.notifier);
                    final currentLocale = ref.read(languageNotifierProvider);

                    final newLocale = currentLocale == AppLocale.ja ? AppLocale.en : AppLocale.ja;
                    languageNotifier.updateLocale(newLocale);
                     */
                  },
                ),
            
            
                ListTile(
                  title: Text(translations.settings.change_database),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: dbMap.entries.map((entry) {
                      return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (states) {
                              // 現在選択されているデータベース名と一致する場合は異なる色を設定
                              return dbName == entry.value ? Colors.blue : Colors.transparent;
                            },
                          ),
                        ),
                        onPressed: () async {
                          

                          final confirm = await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(translations.settings.database_dialog.title),
                                  content: Text('${translations.settings.database_dialog.text}'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(false),
                                      child: Text(translations.settings.database_dialog.no),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(true),
                                      child: Text(translations.settings.database_dialog.yes),
                                    ),
                                  ],
                                );
                              },
                            ) ?? false;

                            if(!confirm){
                              return;
                            }


                            if(context.mounted){
                              showLoadingDialog(context, translations.settings.loading_dialog);
                            }


                            if(interstitialCount % 3 == 0){
                              final interstitialAdNotifier = ref.read(interstitialAdNotifierProvider.notifier);
                              interstitialAdNotifier.showAd();
                              
                            }


                            final interstitialCountNotifier = ref.read(interstitialCountNotifierProvider.notifier);
                            interstitialCountNotifier.updateState();

                            

                            

                            await performDatabaseSwitch(entry.value, ref);


                            if(context.mounted){
                              Navigator.of(context).pop();

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const BookMarkList(tags: null,),
                                ),
                              );

                              



                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(translations.settings.on_change_database.complete),
                                    content: Text(translations.settings.on_change_database.text),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(),
                                        child: Text(translations.settings.on_change_database.ok),
                                      ),
                                    ],
                                  );
                                }
                              );

                            }



                          
                                      
                        },
                        child: Text(dbNameMap[entry.value]!),
                      );
                    }).toList(),
                  ),
                ),


                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text('${translations.settings.current_database}: ${dbNameMap[dbName]}'),
                  ),
                ),

              ],
            ),
          ),
        

          SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
      
          Container(
            height: SizeConfig.blockSizeVertical! * 10,
            color: Colors.white,
            //TODO Admob
            /*
            
             */
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
