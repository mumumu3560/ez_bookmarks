
import 'package:ez_bookmarks/i18n/strings.g.dart';
import 'package:flutter/material.dart';

//https://qiita.com/kokogento/items/87aaf0a0fbc192e51504

//MyDatabase myDatabase = MyDatabase(dbName: "ez_database.sqlite");

//const unexpectedErrorMessage = '予期せぬエラーが起きました';



// ローディングスピナーを含むダイアログを表示する関数
void showLoadingDialog(BuildContext context, String message) {
  final translations = Translations.of(context);
  showDialog(
    context: context,
    barrierDismissible: false, // ユーザーがダイアログ外をタップして閉じられないようにする
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: SizeConfig.blockSizeVertical! * 20,
          child: Column(
            children: [
              Row(
                children: [
                  const CircularProgressIndicator(color: Colors.orange),
                  const SizedBox(width: 20),
                  Text(message), // ローディング中のメッセージ                
                ],
              ),

              SizedBox(height: SizeConfig.blockSizeVertical! * 2),
        
              Text(translations.utils.loading),
        
            ],
          ),
        ),
      );
    },
  );
}


extension ShowSnackBar on BuildContext {
  /// 標準的なSnackbarを表示
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.black,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  /// エラーが起きた際のSnackbarを表示
  void showErrorSnackBar({required String message}) {
    showSnackBar(
      message: message,
      backgroundColor: Theme.of(this).colorScheme.error,
    );
  }

  /// 成功した際のSnackbarを表示
  void showSuccessSnackBar({required String message}) {
    showSnackBar(
      message: message,
      backgroundColor: Theme.of(this).colorScheme.secondary,
    );
  }
}




//ここは機種に依らないサイズを決めるclass
class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  static double? safeAreaTop;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;

    _safeAreaHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;

    _safeAreaVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;

    safeAreaTop = _mediaQueryData!.padding.top;
        
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;
  }
}