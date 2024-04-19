
import 'dart:io';
import 'package:ez_bookmarks/admob/inline_adaptive_banner.dart';
import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:ez_bookmarks/riverpod/db_switcher/db_switcher.dart';
import 'package:ez_bookmarks/riverpod/theme/theme_switcher.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

//ここは設定ページでプライバシーポリシー、テーマ切り替え、データベースの切り替えなどを行える

class SettingPage extends ConsumerWidget{
  const SettingPage({super.key});

  static Map<int,String> dbMap = {
    0: "ez_database",
    1: "ez_database_1",
    2: "ez_database_2",
  };

  static Map<String, int> dbReMap = {
    "ez_database": 0,
    "ez_database_1": 1,
    "ez_database_2": 2,
  };
  
  


  @override
  Widget build(BuildContext context, WidgetRef ref){


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
            
                    if(Platform.isAndroid){
                        const String url = "https://ez-bookmarks.pages.dev/ja/privacy-policy";
                        if(await canLaunchUrl(Uri.parse(url))){
                          await launchUrl(Uri.parse(url));
                        }
            
                      }
            
                      if(Platform.isIOS){
            
                      }
            
                      const String url = "https://ez-bookmarks.pages.dev/ja/privacy-policy";
            
                      if(Platform.isWindows){
                        if(await canLaunchUrl(Uri.parse(url))){
                          await launchUrl(Uri.parse(url));
                        }
            
                      }
            
                  }
                ),
                ListTile(
                  title: Row(
                    children: [
                      const Text('テーマ切り替え'),
                      nowTheme.when(
                        data: (data) => IconButton(
                          onPressed: () async{
                            //final themeNotifier = ref.read(themeModeSwitcherNotifierProvider.notifier);
                            //themeNotifier.updateState(data == 0 ? 1 : 0);
                            //await themeNotifier.updateState(data == 0 ? 1 : 0);

                            int? thisTheme = await dbAdmin.getTheme();
                            final themeNotifier = ref.read(themeModeSwitcherNotifierProvider.notifier);
                            print("げんざいのてーああああああああああああああああああああああああ: $thisTheme");
                    
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
                    print("げんざいのてーああああああああああああああああああああああああ: $thisTheme");
            
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
                  subtitle: Column(
                    children: dbMap.entries.map((entry) {
                      return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (states) {
                              // 現在選択されているデータベース名と一致する場合は異なる色を設定
                              return dbName == entry.value ? Colors.blue : Colors.grey;
                            },
                          ),
                        ),
                        onPressed: () async{
                          final notifier = ref.read(dbSwitcherNotifierProvider.notifier);
                          notifier.updateState(entry.value);

                          final dbAdNotifier = ref.read(dbAdminNotifierProvider.notifier);
                          await dbAdNotifier.closeDB();
                          await dbAdNotifier.updateDB(entry.value);
                          print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
                          print("こんにちはここでDBを変更します。");
                          print("現在のデータベース: $dbName");
                          print("変更後のデータベース: ${entry.value}");

                          print(dbAdNotifier);

                        },
                        child: Text(entry.value),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Text('現在のデータベース: $dbName'),
                    ),
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