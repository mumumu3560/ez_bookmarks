
import 'dart:io';
import 'package:ez_bookmarks/admob/inline_adaptive_banner.dart';
import 'package:ez_bookmarks/riverpod/theme/theme_switcher.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

//ここは設定ページでプライバシーポリシー、テーマ切り替え、データベースの切り替えなどを行える

class SettingPage extends ConsumerWidget{
  const SettingPage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref){


    final nowTheme = ref.watch(themeModeSwitcherNotifierProvider);
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
                        const String url = "https://forms.gle/psbfDJXdyDfa2tb97";
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
                          onPressed: (){
                            final themeNotifier = ref.read(themeModeSwitcherNotifierProvider.notifier);
                            //ref.read(themeModeSwitcherNotifierProvider.notifier).updateState(data == 0 ? 1 : 0);
                            themeNotifier.updateState(data == 0 ? 1 : 0);
                          }, 
                          icon: data == 0 ? const Icon(Icons.light_mode) : const Icon(Icons.dark_mode),
                        ),
                        error: (error, stackTrace) => const Text('エラーが発生しました'),
                        loading: () => const CircularProgressIndicator(),
                      ),
                    ],
                  ),
                  onTap: () async {
            
                    int thisTheme = await myDatabase.getTheme();
                    final themeNotifier = ref.read(themeModeSwitcherNotifierProvider.notifier);
            
            
                    if (thisTheme == 0) {
                      themeNotifier.updateState(1);
                      myDatabase.updateTheme(1);
                    } else {
                      themeNotifier.updateState(0);
                      myDatabase.updateTheme(0);
                    }
                  },
                ),
            
            
                const ListTile(
                  title: Text('データベースの切り替え'),
                  //onTap: () => ref.read(databaseManagementDialogProvider).show(),
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