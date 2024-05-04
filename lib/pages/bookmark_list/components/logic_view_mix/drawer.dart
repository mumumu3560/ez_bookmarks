import 'dart:io';

import 'package:ez_bookmarks/i18n/strings.g.dart';
import 'package:ez_bookmarks/pages/database_management/database_management_page.dart';
import 'package:ez_bookmarks/pages/search/search_page.dart';
import 'package:ez_bookmarks/pages/setting/setting_page.dart';
import 'package:ez_bookmarks/riverpod/db_switcher/db_switcher.dart';
import 'package:ez_bookmarks/riverpod/local/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';



class CustomDrawer extends ConsumerWidget {
  static Map<String, String> dbNameMap = {
    "classifier_database1": "DB1",
    "classifier_database2": "DB2",
    "classifier_database3": "DB3",
  };


  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbName = ref.watch(dbSwitcherNotifierProvider);

    final translations = Translations.of(context);

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
            title: Text(translations.drawer.tags),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchPage(),
              ));
            },
          ),
          ListTile(
            title: Text(translations.drawer.management),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const DatabaseManagementPage(),
              ));
            },
          ),

          //設定ページを開く

          ListTile(
            title: Text(translations.drawer.settings),
            onTap: () {

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SettingPage(),
              ));
            },
          ),


          ListTile(
            title: Text(translations.drawer.inquiry),
            onTap: () async {
              if(Platform.isAndroid){
                  //String url = "https://forms.gle/KkHYp3keoW5iepQN9";
                  String url = translations.external_url.inquiry;
                  if(await canLaunchUrl(Uri.parse(url))){
                    await launchUrl(Uri.parse(url));
                  }

                }

                if(Platform.isIOS){

                }

                

                if(Platform.isWindows){
                  String url = translations.external_url.inquiry;
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
