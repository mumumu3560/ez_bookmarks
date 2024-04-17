
import 'package:ez_bookmarks/drift/database_1/database.dart';
import 'package:ez_bookmarks/pages/bookmark_list/bookmark_list_page.dart';
import 'package:ez_bookmarks/riverpod/theme/theme_switcher.dart';
import 'package:flutter/material.dart';

import 'package:ez_bookmarks/utils/various.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:ez_bookmarks/firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //firebase追加
  /*
  
  
   */

  MobileAds.instance.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  


  runApp(
    ProviderScope(child: MyApp(database: myDatabase, ))
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({
    required this.database,
    //required this.themeId,
    super.key,
  });

  final MyDatabase database;
  //final int themeId;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);

    final nowTheme = ref.watch(themeModeSwitcherNotifierProvider);


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bookmarks with Tags',
      theme: ThemeData(
        textTheme: GoogleFonts.sawarabiMinchoTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
        // ライトモード用のテーマ設定
        primarySwatch: Colors.blue,
        fontFamily: 'CustomFont', // カスタムフォントを適用
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts.sawarabiMinchoTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        
        ),
        // ダークモード用のテーマ設定
        primarySwatch: Colors.blueGrey,
        fontFamily: 'CustomFont', // カスタムフォントを適用
        brightness: Brightness.dark,
      ),
      
      themeMode: nowTheme.when(
        data: (themeId) => themeId == 0 ? ThemeMode.light : ThemeMode.dark, 
        error: (error, stackTrace) => ThemeMode.light,
        loading: () => ThemeMode.light,
      ),

      
      home: const BookMarkList(tags: null),
    );
  }
}
