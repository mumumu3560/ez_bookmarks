import 'package:ez_bookmarks/i18n/strings.g.dart';
import 'package:ez_bookmarks/pages/search/components/almost_view/help_widget.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



void showSearchHelpDialog(BuildContext context) {
  final translations = Translations.of(context);

  List<String> searchHelpContents = [
    translations.search.search_dialog.page_1.text,
    translations.search.search_dialog.page_2.text,
    translations.search.search_dialog.page_3.text,
  ];


  showDialog(
    context: context,
    builder: (context) {
      final PageController pageController = PageController(initialPage: 0);
      final List<Widget> pages = [
        HelpPage(content: searchHelpContents[0], title: translations.search.search_dialog.page_1.title,),
        HelpPage(content: searchHelpContents[1], title: translations.search.search_dialog.page_2.title,),
        HelpPage(content: searchHelpContents[2], title: translations.search.search_dialog.page_3.title,),
      ];
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0), // 角を丸くする
        ),
        child: Container(
          height: SizeConfig.blockSizeVertical! * 50,  // 高さを適切に設定
          width: SizeConfig.blockSizeHorizontal! * 80,  // 幅を適切に設定
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: pages,
                ),
              ),
              SizedBox(height: 10,),
              SmoothPageIndicator(
                controller: pageController,
                count: pages.length,
                effect: WormEffect(),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      );
    },
  );
}
