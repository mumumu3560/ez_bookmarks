import 'package:ez_bookmarks/admob/inline_adaptive_banner.dart';
import 'package:ez_bookmarks/pages/bookmark_list/bookmark_list_page.dart';
import 'package:ez_bookmarks/pages/search/components/almost_logic/almost_logic.dart';
import 'package:ez_bookmarks/pages/search/components/almost_view/dialogs.dart';
import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:ez_bookmarks/riverpod/desc_or_asc/desc_or_asc_switcher.dart';
import 'package:ez_bookmarks/riverpod/sort_bookmarks/sort_kind_switcher.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter/material.dart';
import 'package:ez_bookmarks/drift/database_1/database.dart';
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late Future<Map<String, List<Tag>>> _tagsByGenre;
  final TextEditingController _genreController = TextEditingController();
  List<Genre> _genresFuture = [];

  final List<Tag> selectedTags = [];
  List<GenreColor> genreColors = [];

  Future<void> initFetch() async{
    
    genreColors = await getGenreColors();
    _genresFuture = await getAllGenres();
    
  }




Future<List<Genre>> getAllGenres () async{
  return ref.read(dbAdminNotifierProvider).allGenres();
}

Future<void> _onSearch(List<Tag> tags) async{
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookMarkList(tags: tags),
      ),
    );
  }


  //全てのジャンルを取得
  Future<List<GenreColor>> getGenreColors() async {
    //return myDatabase.allGenreColors();
    return ref.read(dbAdminNotifierProvider).allGenreColors();
  }

  //このダイアログでは、genreColorsからジャンルを選択して、そのジャンルに属するタグのジャンルを変更することもできる。
  //新しく自分で入力したものを選ぶこともできる。
  void showEditDialog(List<Tag> selectedTags){

    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text("ジャンルの編集"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: "ジャンル名",
                  ),
                  controller: _genreController,
                ),
            
                SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
            
                //ここにジャンルの選択肢を表示する。genreColorsはListなので注意
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: _genresFuture.map((genre) => ActionChip(
                    label: Text(genre.genre ?? "No genre"),
                    onPressed: () {
                      _genreController.text = genre.genre ?? "";
                    },
                  )).toList(),
                
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: const Text("キャンセル"),
            ),
            TextButton(
              onPressed: () async{
                // タグのジャンルを変更する処理
                for(int i = 0; i < selectedTags.length; i++){
                  await changeTagGenre(ref, selectedTags[i].id, _genreController.text);
                }

                //_genresFuture = await myDatabase.allGenres();
                _genresFuture = await getAllGenres();

                setState(() {
                  selectedTags.clear();
                  _tagsByGenre = getTagsByGenre(ref);
                  _genresFuture = _genresFuture;
                  
                });


                if(context.mounted){
                  Navigator.of(context).pop();
                }
              }, 
              child: const Text("変更"),
            ),
            
          ],
        );
      },
    );
  }




  @override
  void initState() {
    super.initState();
    //_tagsByGenre = getTagsByGenre();
    initFetch();
  }




  int containNum = 0;

  @override
  Widget build(BuildContext context) {
    final sortKind = ref.watch(sortKindSwitcherNotifierProvider);
    final descOrAsc = ref.watch(descOrAscSwitcherNotifierProvider);

    return Scaffold(

      /*
      
       */

      appBar: AppBar(
        title: const Text("タグ編集&検索"),
        actions: [
          IconButton(
            onPressed: () => showSearchHelpDialog(context),
            icon: const Icon(Icons.help),
          ),
        ],
      ),


      body: Column(
        children: [
      
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Text("選択したタグ ${selectedTags.length}個: ${containNum}件一致"),
                  Text("$containNum件のブックマークが見つかりました"),

                  SizedBox(height: SizeConfig.blockSizeVertical! * 2,),


                        
                  Wrap(
                    //mainaxisの間隔
                    spacing: 8.0,
                    //crossaxisの間隔
                    runSpacing: 8.0,
                    children: selectedTags.map((tag) => Chip(
                      label: Text(
                        "${tag.tagName}: ${tag.sum}",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      onDeleted: () async {
                        
                        setState(() {
                          selectedTags.remove(tag);
                        });
                        containNum = await calcContainBookmarks(ref, selectedTags, sortKind, descOrAsc);
                        setState(() {
                          containNum = containNum;
                        });
                      },
                    )).toList(),
                        
                  ),

                  SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      ElevatedButton(
                        /*
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.lightBlue),

                        ),
                         */
                        onPressed: () async{
                          if(selectedTags.isNotEmpty) {
                            
                            _onSearch(selectedTags);
                          }
                        },
                        
                        child: const Text("検索"),
                      ),

                      SizedBox(width: SizeConfig.blockSizeHorizontal! * 2,),

                      ElevatedButton(
                        onPressed: () async{
                          setState(() {
                            selectedTags.clear();
                            containNum = 0;
                          });
                        },
                        //icon: Icon(Icons.clear),
                        child: const Text("クリア"),
                      ),

                      SizedBox(width: SizeConfig.blockSizeHorizontal! * 2,),


                      ElevatedButton(
                        onPressed: () async{
                          selectedTags.isNotEmpty ? showEditDialog(selectedTags) : null;
                          /*
                          setState(() {
                            
                          });
                           */
                        },
                        //icon: Icon(Icons.clear),
                        child: const Text("ジャンル変更"),
                      ),
                    ],
                  ),

                  SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
                  
                  FutureBuilder<Map<String, List<Tag>>>(
                    //future: _tagsByGenre,
                    future: getTagsByGenre(ref),
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
                                        label: Text("${tag.tagName}: ${tag.sum}"),
                                        onPressed: () async{
                                          
                                          if (!selectedTags.contains(tag)) {
                                            setState(() {
                                              selectedTags.add(tag);
                                              
                                            });
                                            containNum = await calcContainBookmarks(ref, selectedTags, sortKind, descOrAsc);
                  
                                            setState(() {
                                              containNum = containNum;
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
        
          Container(
            height: SizeConfig.blockSizeVertical! * 10,
            color: Colors.white,
            //TODO Admob
            child: InlineAdaptiveAdBanner(
              requestId: "TAG", 
              adHeight: SizeConfig.blockSizeVertical!.toInt() * 10,
            ),
            /*
            
            */
            /*
            
            */
          ),
        ],
      ),
    );
  }
}
