import 'dart:io';

import 'package:ez_bookmarks/pages/database_management/database_management_page.dart';
import 'package:ez_bookmarks/pages/search/search_page.dart';
import 'package:ez_bookmarks/pages/setting/setting_page.dart';
import 'package:ez_bookmarks/riverpod/db_switcher/db_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';



class CustomDrawer extends ConsumerWidget {
  static Map<String, String> dbNameMap = {
    "classifier_database_1": "DB1",
    "classifier_database_2": "DB2",
    "classifier_database_3": "DB3",
  };


  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbName = ref.watch(dbSwitcherNotifierProvider);

    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            child: DrawerHeader(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Classifier'),
                    subtitle: Text(dbNameMap[dbName]!),
                  ),
                ],
              )
            ),
          ),
          ListTile(
            title: const Text('タグから検索&編集'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchPage(),
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
                  const String url = "https://forms.gle/KkHYp3keoW5iepQN9";
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
