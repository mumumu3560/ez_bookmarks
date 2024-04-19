
import 'dart:io';
import 'package:ez_bookmarks/admob/inline_adaptive_banner.dart';
import 'package:ez_bookmarks/env/env.dart';
import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:ez_bookmarks/riverpod/db_switcher/db_switcher.dart';
import 'package:ez_bookmarks/riverpod/theme/theme_switcher.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';


import 'package:google_mobile_ads/google_mobile_ads.dart';

//ここは設定ページでプライバシーポリシー、テーマ切り替え、データベースの切り替えなどを行える

class SettingPage extends HookConsumerWidget{
  const SettingPage({super.key});

  static Map<int,String> dbMap = {
    0: "ez_database",
    1: "ez_database_1",
    2: "ez_database_2",
  };

  static Map<String, String> dbNameMap = {
    "ez_database": "DB1",
    "ez_database_1": "DB2",
    "ez_database_2": "DB3",
  };

  static Map<String, int> dbReMap = {
    "ez_database": 0,
    "ez_database_1": 1,
    "ez_database_2": 2,
  };


  static final String adUnitId = Env.i1;


  @override
  Widget build(BuildContext context, WidgetRef ref){

    final interstitialAd = useState<InterstitialAd?>(null);
    final isAdLoaded = useState(false);

    useEffect(() {
      InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd.value = ad;
            isAdLoaded.value = true;
          },
          onAdFailedToLoad: (error) {
            print('広告のロードに失敗しました: $error');
          },
        ),
      );

      return () {
        interstitialAd.value?.dispose();
      };
    }, const []);

    final nowTheme = ref.watch(themeModeSwitcherNotifierProvider);

    final dbName = ref.watch(dbSwitcherNotifierProvider);
    //final myDatabase = ref.watch(dbAdminNotifierProvider.notifier);

    final dbAdmin = ref.watch(dbAdminNotifierProvider);


    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),

      //ListTileのリストを作成
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                
                ListTile(
                  title: const Text('プライバシーポリシー'),
                  onTap: () async{
            
                    
            
                  }
                ),
                ListTile(
                  title: Row(
                    children: [
                      const Text('テーマ切り替え'),
                      nowTheme.when(
                        data: (data) => IconButton(
                          onPressed: () async{

                            int? thisTheme = await dbAdmin.getTheme();
                            final themeNotifier = ref.read(themeModeSwitcherNotifierProvider.notifier);
                            
                            if (thisTheme == 0) {
                              await themeNotifier.updateState(1);
                              //myDatabase.updateTheme(1);
                              await dbAdmin.updateTheme(1);

                            } else if(thisTheme == 1){
                              await themeNotifier.updateState(0);
                              //myDatabase.updateTheme(0);
                              await dbAdmin.updateTheme(0);
                            }
                            else{
                              await dbAdmin.insertTheme();

                              await themeNotifier.updateState(1);
                              //myDatabase.updateTheme(0);
                              await dbAdmin.updateTheme(1);
                            }


                            


                          }, 
                          icon: data == 0 ? const Icon(Icons.light_mode) : const Icon(Icons.dark_mode),
                        ),
                        error: (error, stackTrace) => const Text('エラーが発生しました'),
                        loading: () => const CircularProgressIndicator(),
                      ),
                    ],
                  ),
                  onTap: () async {
            
                    int? thisTheme = await dbAdmin.getTheme();
                    final themeNotifier = ref.read(themeModeSwitcherNotifierProvider.notifier);
                    
            
                    if (thisTheme == 0) {
                      themeNotifier.updateState(1);
                      //myDatabase.updateTheme(1);
                      dbAdmin.updateTheme(1);

                    } else if(thisTheme == 1){
                      themeNotifier.updateState(0);
                      //myDatabase.updateTheme(0);
                      dbAdmin.updateTheme(0);
                    }
                    else{
                      dbAdmin.insertTheme();
                      themeNotifier.updateState(1);
                      //myDatabase.updateTheme(0);
                      dbAdmin.updateTheme(1);
                    }






                  },
                ),
            
            
                ListTile(
                  title: const Text('データベースの切り替え'),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //幅を指定

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
                        onPressed: () async{

                          if (isAdLoaded.value) {
                            interstitialAd.value!.show();
                            interstitialAd.value!.fullScreenContentCallback = FullScreenContentCallback(
                              onAdDismissedFullScreenContent: (InterstitialAd ad) {
                                ad.dispose();
                                isAdLoaded.value = false;
                                // 広告が閉じられた後にデータベース切り替え処理を実行
                              },
                            );
                          }

                          final notifier = ref.read(dbSwitcherNotifierProvider.notifier);
                          notifier.updateState(entry.value);

                          final dbAdNotifier = ref.read(dbAdminNotifierProvider.notifier);
                          await dbAdNotifier.closeDB();
                          await dbAdNotifier.updateDB(entry.value);

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
                    child: Text('現在のデータベース: ${dbNameMap[dbName]}'),
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