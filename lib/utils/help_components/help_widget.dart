import 'package:flutter/material.dart';

class helpWidget extends StatelessWidget {
  const helpWidget({
    super.key,
    required this.index
  });

  final int index;

  void showHelp(BuildContext context, int index){

    showDialog(
      context: context, 
      builder: (BuildContext context) {
        switch(index){
          case 0:
            return bookmarkDialog();
          case 1:
            return tagDialog();
          case 2:
            return searchDialog();
          case 3:
            return settingDialog();
          default:
            return Container();
        }
      },
    );

  }


  Widget tutorialPage(String text, String imagePath) {
  return Container(
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Image.asset(imagePath)
        ),
        //SizedBox(height: 20),
        Text(text, textAlign: TextAlign.center),
      ],
    ),
  );
}


void showTutorialDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          height: 400, // ダイアログのサイズを適宜調整
          child: PageView(
            children: [
              tutorialPage("ページ1のテキスト", "assets/images/no_image.png"),
              tutorialPage("ページ2のテキスト", "assets/images/no_image.png"),
              tutorialPage("ページ3のテキスト", "assets/images/no_image.png"),
              // 必要に応じて更にページを追加
            ],
          ),
        ),
      );
    },
  );
}





  //ここではタグページのヘルプダイアログを表示
  Widget bookmarkDialog(){
    return Container();
  }

  Widget tagDialog(){
    return Container();
  }

  Widget searchDialog(){
    return Container();
  }

  Widget settingDialog(){
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showTutorialDialog(context),
      icon: const Icon(Icons.help),
    );
  }
}