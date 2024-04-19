
import 'dart:io';
import 'package:ez_bookmarks/admob/inline_adaptive_banner.dart';
import 'package:ez_bookmarks/env/env.dart';
import 'package:ez_bookmarks/pages/setting/components/almost_logic/almost_logic.dart';
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
  bool isMounted = true;

  InterstitialAd.load(
    adUnitId: adUnitId,
    request: const AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (ad) {
        if (isMounted) {
          interstitialAd.value = ad;
          isAdLoaded.value = true;
        } else {
          ad.dispose(); // もしコンポーネントがアンマウントされていたら、ロードされた広告を即座に破棄
        }
      },
      onAdFailedToLoad: (error) {
        if (isMounted) {
          print('広告のロードに失敗しました: $error');
        }
      },
    ),
  );

  return () {
    isMounted = false; // コンポーネントがアンマウントされたときにフラグをfalseに設定
    interstitialAd.value?.dispose(); // 広告を破棄
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
                        onPressed: () async {



                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('確認'),
                                content: const Text('データベースを切り替えますか？'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('いいえ'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text('はい'),
                                  ),
                                ],
                              );
                            },
                          ) ?? false;

                          if(!confirm){
                            return;
                          }


                          if (isAdLoaded.value) {
                            // 広告がロードされていれば表示
                            
                            interstitialAd.value!.fullScreenContentCallback = FullScreenContentCallback(
                              onAdDismissedFullScreenContent: (InterstitialAd ad) async{

                                ad.dispose();
                                isAdLoaded.value = false;

                                if(context.mounted){
                                  context.showSuccessSnackBar(message: "データベースを切り替えました");

                                }


                              },
                            );
                            await interstitialAd.value!.show();
                            await performDatabaseSwitch(entry.value, ref);
                          } else {
                            // 広告がロードされていない場合は直接データベース切り替え
                            performDatabaseSwitch(entry.value, ref);
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