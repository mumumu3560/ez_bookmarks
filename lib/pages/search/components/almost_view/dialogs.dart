import 'package:ez_bookmarks/pages/search/components/almost_view/help_widget.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const List<String> searchHelpContents = [
  'このページではタグからブックマークを検索したり、タグのジャンルを変更することができます。',
  'ブックマークに登録されたタグ一覧を下から選んで検索できます。\n\nタグは複数選択できます。',
  'ジャンルはタグを分類したもので、デフォルトは「分類なし」となっています。\n\nタグを選択し、ジャンルを変更することができます。',
];

void showSearchHelpDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      final PageController pageController = PageController(initialPage: 0);
      final List<Widget> pages = [
        HelpPage(content: searchHelpContents[0], title: "ページについて"),
        HelpPage(content: searchHelpContents[1], title: "検索について"),
        HelpPage(content: searchHelpContents[2], title: "ジャンルについて"),
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
