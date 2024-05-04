import 'dart:io';

import 'package:ez_bookmarks/admob/inline_adaptive_banner.dart';
import 'package:ez_bookmarks/i18n/strings.g.dart';
import 'package:ez_bookmarks/pages/add_bookmark/components/almost_logic/almost_logic.dart';
import 'package:flutter/material.dart';
import 'package:ez_bookmarks/database/drift/database_1/database.dart';

import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddBookmarkPage extends ConsumerStatefulWidget {
  const AddBookmarkPage({super.key});

  @override
  _AddBookmarkPageState createState() => _AddBookmarkPageState();
}

class _AddBookmarkPageState extends ConsumerState<AddBookmarkPage> {

  final TextEditingController _contentsController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _aaa = TextEditingController();
  final List<String> tags = [];


  late Future<Map<String, List<Tag>>> _tagsByGenre;

  

  Map<int, Color> genreColors = {
    // GenreColorsテーブルのidに基づいた色の設定
    0: Colors.red,
    1: Colors.green,
    2: Colors.blue,
    3: Colors.orange,
  };


  Image tmpImage = Image.asset('assets/images/no_image.png');

  String? imagePath; // 画像のパスを保持する変数
  dynamic selectedImage1; // 画像を選択するための変数

  @override
  void initState() {
    // TODO: implement initState
    _tagsByGenre = getTagsByGenre(ref);
  }
  
  @override
  void dispose() {
    _urlController.dispose();
    _tagController.dispose();
    _contentsController.dispose();
    super.dispose();
  }

  

  // タグを追加するメソッド
  void _addTag() {
    final String newTag = _tagController.text.trim();
    if (newTag.isNotEmpty && !tags.contains(newTag)) {
      setState(() {
        tags.add(newTag);
        _tagController.clear();
      });
    }
  }

  // タグを削除するメソッド
  void _removeTag(String tag) {
    setState(() {
      tags.remove(tag);
    });
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path; // 選択された画像のパスを保存
        tmpImage = Image.file(File(imagePath!));
      });
    } else {
      // ユーザーが画像を選択しなかった場合の処理
    }
  }


  @override
  Widget build(BuildContext context) {

  

    // Fileオブジェクトを作成
    final file = File(imagePath ?? '');

    // Fileが実際に存在するかチェック
    final fileExists = file.existsSync();

    //言語設定
    final translations = Translations.of(context);
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(translations.add_bookmarks.title),
        actions: [
          ElevatedButton(
              onPressed: () async{
                final bool isOk = await addBookmark(ref, context, _contentsController.text, _urlController.text, tags, imagePath);
                if(_urlController.text.isEmpty) return;
                if(!isOk) return;
                
                if(context.mounted){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(translations.add_bookmarks.complete_dialog.title),
                        content: Text(translations.add_bookmarks.complete_dialog.text),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text(translations.add_bookmarks.complete_dialog.close),
                          ),
                        ],
                      );
                    },
                  );
                }
                
              
              },
              child: Text(translations.add_bookmarks.complete),
            ),
        ],
      ),
      body: Column(
        children: [
    
          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
              
                  children: [
                    TextFormField(
                      //3行のテキストフィールド
                      maxLines: 3,
                      controller: _contentsController,
                      decoration: InputDecoration(labelText: translations.add_bookmarks.explain),
                    ),
                          
                          
                    TextFormField(
                      controller: _urlController,
                      decoration: const InputDecoration(
                        labelText: 'URL',
                      ),
                    ),
              
                    SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
              
              ElevatedButton(
                onPressed: _selectImage,
                child: Text(translations.add_bookmarks.select_image),
              ),
              
              //画像を表示
              SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
              
              SizedBox(
                width: 100,
                height: 100,
                //child: tmpImage,
                child: fileExists 
                  ? Image.file(file) 
                  : Image.asset('assets/images/no_image.png'),
              
              ),
                          
                          
                    TextFormField(
                      controller: _tagController,
                      decoration: InputDecoration(
                        labelText: translations.add_bookmarks.input,
                        /*
                        
                         */
                          
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.add, color: Colors.blue),
                          onPressed: _addTag,
                        ),
                          
                      ),
                    ),
                          
                    SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
                          
                    Text(translations.add_bookmarks.tag_show),
                          
                    SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
                          
                    Wrap(
                      spacing: 8.0,
                      children: tags.map((tag) => Chip(
                        label: Text(tag),
                        onDeleted: () => _removeTag(tag),
                      )).toList(),
                    ),
                          
                    SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
                          
                    Text(translations.add_bookmarks.exist_tag),
                          
                    
                    FutureBuilder<Map<String, List<Tag>>>(
                      //future: getTagsByGenre(ref),
                      future: _tagsByGenre,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text("No tags found"));
                        }
                    
                        var tagsByGenre = snapshot.data!;
                    
                        return Column(
                          children: tagsByGenre.entries.map((entry) {
                            return Card(
                              child: ExpansionTile(
                                title: Text(
                                  entry.key, 
                                  style: const TextStyle(
                                    //color: genreColors[entry.value.first.id] ?? Colors.black
                    
                                  
                                  ),
                                ),
                                children: [
                                  SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
                                  Wrap(
                                    //mainaxisの間隔
                                    spacing: 8.0,
                                    //crossaxisの間隔
                                    runSpacing: 8.0,
                                    children: entry.value.map((tag) => Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ActionChip(
                                          label: Text(tag.tagName),
                                          onPressed: () {
                                            
                                            if (!tags.contains(tag.tagName)) {
                                              setState(() {
                                                tags.add(tag.tagName);
                                              });
                                            }
                                          },
                                        ),
                                        
                                      ],
                                    )).toList(),
                                  ),
                    
                                ],
                              ),
                            );
                          }).toList(),
                        );
                    
                        
                    
                    
                    
                    
                    
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
      
      
      
          SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
      
          Container(
            height: SizeConfig.blockSizeVertical! * 10,
            color: Colors.white,
            //TODO Admob
            
            
            /*
            
            
            
            */
            child: InlineAdaptiveAdBanner(
              requestId: "ADD", 
              adHeight: SizeConfig.blockSizeVertical!.toInt() * 10,
            ),
          
          ),

          SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
          
        ],
      ),
    );
  }
}
