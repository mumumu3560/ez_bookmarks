/*

import 'package:ez_bookmarks/admob/inline_adaptive_banner.dart';
import 'package:ez_bookmarks/pages/bookmark_list/bookmark_list_page.dart';
import 'package:ez_bookmarks/pages/search/components/almost_logic/almost_logic.dart';
import 'package:ez_bookmarks/pages/search/components/almost_view/dialogs.dart';
import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:ez_bookmarks/riverpod/desc_or_asc/desc_or_asc_switcher.dart';
import 'package:ez_bookmarks/riverpod/search_relative/genres_watcher/genres_watcher.dart';
import 'package:ez_bookmarks/riverpod/search_relative/tags/tags_watcher.dart';
import 'package:ez_bookmarks/riverpod/search_relative/contain_num/contain_num_watcher.dart';
import 'package:ez_bookmarks/riverpod/sort_bookmarks/sort_kind_switcher.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter/material.dart';
import 'package:ez_bookmarks/database/drift/database_1/database.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends HookConsumerWidget{

  final TextEditingController _genreController = TextEditingController();

  List<GenreColor> genreColors = [];

  SearchPage({super.key});

  Future<void> initFetch(WidgetRef ref) async{
    final genresWatcherNotifier = ref.read(genresWatcherNotifierProvider.notifier);
    final allGenres = await getAllGenres(ref);
    genresWatcherNotifier.updateState(allGenres);
    
    genreColors = await getGenreColors(ref);
  }




Future<List<Genre>> getAllGenres ( WidgetRef ref) async{
  return ref.read(dbAdminNotifierProvider).allGenres();
}

Future<void> _onSearch(BuildContext context, List<Tag> tags) async{
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookMarkList(tags: tags),
      ),
    );
  }


  //全てのジャンルを取得
  Future<List<GenreColor>> getGenreColors(WidgetRef ref) async {
    //return myDatabase.allGenreColors();
    return ref.read(dbAdminNotifierProvider).allGenreColors();
  }

  //このダイアログでは、genreColorsからジャンルを選択して、そのジャンルに属するタグのジャンルを変更することもできる。
  //新しく自分で入力したものを選ぶこともできる。
  void showEditDialog(BuildContext context, WidgetRef ref, List<Tag> selectedTags, List<Genre> allGenres){

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
                  //children: _genresFuture.map((genre) => ActionChip(
                  children: allGenres.map((genre) => ActionChip(
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
                //_genresFuture = await getAllGenres();
                final allGenres = await getAllGenres(ref);
                final genresWatcherNotifier = ref.read(genresWatcherNotifierProvider.notifier);
                genresWatcherNotifier.updateState(allGenres);


                final tagsNotifier = ref.read(tagsWatcherNotifierProvider.notifier);
                tagsNotifier.clearTags();

                /*
                setState(() {
                  //selectedTags.clear();
                  //_tagsByGenre = getTagsByGenre(ref);
                  //_genresFuture = _genresFuture;
                  
                });
                 */


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
  Widget build(BuildContext context, WidgetRef ref) {

    useEffect(() {
      initFetch(ref);
      return null;
    }, []);

    final _tagsByGenre = useState<Future<Map<String, List<Tag>>>?>(null);

    useEffect(() {
      // 初期化
      _tagsByGenre.value = getTagsByGenre(ref);
      return null;
    }, []);  // 依存配列が空なので、コンポーネントのマウント時にのみ実行


    
    



    final sortKind = ref.watch(sortKindSwitcherNotifierProvider);
    final descOrAsc = ref.watch(descOrAscSwitcherNotifierProvider);
    final tagsWatcher = ref.watch(tagsWatcherNotifierProvider);
    final containNumWatcher = ref.watch(containNumWatcherNotifierProvider);
    final genresWatcher = ref.watch(genresWatcherNotifierProvider);

    // タグウォッチャーの状態変更を検知
    useEffect(() {
      // タグの状態が変更された場合にのみFutureを更新
      _tagsByGenre.value = getTagsByGenre(ref);
      return null;
    }, [tagsWatcher]); // tagsWatcherが変更されたときにのみ実行
    

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

                  Text("$containNumWatcher件のブックマークが見つかりました"),

                  SizedBox(height: SizeConfig.blockSizeVertical! * 2,),


                        
                  Wrap(
                    //mainaxisの間隔
                    spacing: 8.0,
                    //crossaxisの間隔
                    runSpacing: 8.0,
                    //children: selectedTags.map((tag) => Chip(
                    children: tagsWatcher.map((tag) => Chip(
                      label: Text(
                        "${tag.tagName}: ${tag.sum}",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      onDeleted: () async {
                        
                        /*
                        setState(() {
                          selectedTags.remove(tag);
                        });
                         */
                        final tagsWatcherNotifier = ref.read(tagsWatcherNotifierProvider.notifier);
                        tagsWatcherNotifier.removeTag(tag);

                        //containNum = await calcContainBookmarks(ref, selectedTags, sortKind, descOrAsc);
                        final nowNum = await calcContainBookmarks(ref, tagsWatcher, sortKind, descOrAsc);
                        //containNum = await calcContainBookmarks(ref, tagsWatcher, sortKind, descOrAsc);
                        final containNumNotifier = ref.read(containNumWatcherNotifierProvider.notifier);
                        containNumNotifier.updateState(nowNum);
                        /*
                        setState(() {
                          containNum = containNum;
                        });
                         */
                      },
                    )).toList(),
                        
                  ),

                  SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      ElevatedButton(
                        onPressed: () async{
                          if(tagsWatcher.isNotEmpty) {
                            
                            _onSearch(context, tagsWatcher);
                          }
                        },
                        
                        child: const Text("検索"),
                      ),

                      SizedBox(width: SizeConfig.blockSizeHorizontal! * 2,),

                      ElevatedButton(
                        onPressed: () async{
                          /*
                          setState(() {
                            selectedTags.clear();
                            containNum = 0;
                          });
                           */

                          final tagsWatcherNotifier = ref.read(tagsWatcherNotifierProvider.notifier);
                          tagsWatcherNotifier.clearTags();

                          final containNumNotifier = ref.read(containNumWatcherNotifierProvider.notifier);
                          containNumNotifier.updateState(0);

                        },
                        //icon: Icon(Icons.clear),
                        child: const Text("クリア"),
                      ),

                      SizedBox(width: SizeConfig.blockSizeHorizontal! * 2,),


                      ElevatedButton(
                        onPressed: () async{
                          tagsWatcher.isNotEmpty ? showEditDialog(context, ref,tagsWatcher, genresWatcher) : null;

                        },
                        //icon: Icon(Icons.clear),
                        child: const Text("ジャンル変更"),
                      ),
                    ],
                  ),
                  
                  
                  SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
                  
                  FutureBuilder<Map<String, List<Tag>>>(
                    //future: _tagsByGenre,
                    //future: getTagsByGenre(ref),
                    future: _tagsByGenre.value,
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
                                          
                                          if (!tagsWatcher.contains(tag)) {
                                            /*
                                            setState(() {
                                              selectedTags.add(tag);
                                              
                                            });
                                             */

                                            final tagsWatcherNotifier = ref.read(tagsWatcherNotifierProvider.notifier);
                                            tagsWatcherNotifier.addTag(tag);

                                            final nowNum = await calcContainBookmarks(ref, tagsWatcher, sortKind, descOrAsc);
                                            //containNum = await calcContainBookmarks(ref, tagsWatcher, sortKind, descOrAsc);
                                            final containNumNotifier = ref.read(containNumWatcherNotifierProvider.notifier);
                                            containNumNotifier.updateState(nowNum);

                                            /*
                                            setState(() {
                                              containNum = containNum;
                                            });
                                            */
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

 */






























/*


 */