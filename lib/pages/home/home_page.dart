import 'package:ez_bookmarks/pages/bookmark_list/bookmark_list_page.dart';
import 'package:ez_bookmarks/pages/home/gdpr.dart';
import 'package:ez_bookmarks/pages/home/initialized_helper.dart';
import 'package:ez_bookmarks/riverpod/gdpr/consent/gdpr_consent.dart';
import 'package:ez_bookmarks/riverpod/gdpr/judge_in_gdpr/gdpr_jud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
  });


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  final _initializer = InitializedHelper();

  Future<void> _initialize() async{

    await _initializer.initialize(ref);

  }

  



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialize();

    
  }

  @override
  Widget build(BuildContext context) {

    
    //gdprの同意が取れているか
    final gdprConsent = ref.watch(gdprConsentNotifierProvider);

    //gdpr対応国か
    final gdprJudge = ref.watch(gdprJudgeNotifierProvider);

    //GDPRの対象国で無い場合は、そのまま表示
    //GDPRの対象国の場合は、同意が取れているかを確認
    return (gdprConsent == const AsyncValue.data(false) && gdprJudge == true)
      ? const Center(child: CircularProgressIndicator())
      : const BookMarkList(tags: null);

  }

}




