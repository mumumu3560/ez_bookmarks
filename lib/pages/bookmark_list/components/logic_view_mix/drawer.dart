import 'dart:io';

import 'package:ez_bookmarks/pages/database_management/database_management_page.dart';
import 'package:ez_bookmarks/pages/search/search_page.dart';
import 'package:ez_bookmarks/pages/setting/setting_page.dart';
import 'package:ez_bookmarks/riverpod/theme/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';



class CustomDrawer extends ConsumerWidget {


  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nowTheme = ref.watch(themeModeSwitcherNotifierProvider);

    return Drawer(
      child: ListView(
        children: [
          const SizedBox(
            child: DrawerHeader(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    subtitle: Text('Bookmarks with Tags'),
                    title: Text("データベース1"),
                  ),
                ],
              )
            ),
          ),
          ListTile(
            title: const Text('タグから検索&編集'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ));
            },
          ),
          ListTile(
            title: const Text('インポートとバックアップ'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const DatabaseManagementPage(),
              ));
            },
          ),
          /*
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
                //ref.read(themeModeSwitcherNotifierProvider.notifier).updateState(1);
                themeNotifier.updateState(1);
                myDatabase.updateTheme(1);
              } else {
                //ref.read(themeModeSwitcherNotifierProvider.notifier).updateState(0);
                themeNotifier.updateState(0);
                myDatabase.updateTheme(0);
              }
            },
          ),
           */


          //設定ページを開く

          ListTile(
            title: const Text('設定'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SettingPage(),
              ));
            },
          ),


          ListTile(
            title: const Text('お問い合わせ'),
            onTap: () async {
              if(Platform.isAndroid){
                  const String url = "https://forms.gle/psbfDJXdyDfa2tb97";
                  if(await canLaunchUrl(Uri.parse(url))){
                    await launchUrl(Uri.parse(url));
                  }

                }

                if(Platform.isIOS){

                }

                const String url = "https://forms.gle/psbfDJXdyDfa2tb97";

                if(Platform.isWindows){
                  if(await canLaunchUrl(Uri.parse(url))){
                    await launchUrl(Uri.parse(url));
                  }

                }

            },
          ),
        ],
      ),
    );
  }
}
