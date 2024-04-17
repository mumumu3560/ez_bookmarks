import 'package:ez_bookmarks/admob/inline_adaptive_banner.dart';
import 'package:ez_bookmarks/pages/bookmark_list/components/almost_logic/almost_logic.dart';
import 'package:ez_bookmarks/pages/bookmark_list/components/logic_view_mix/bookmark_card.dart';
import 'package:ez_bookmarks/pages/bookmark_list/components/logic_view_mix/dialogs.dart';
import 'package:ez_bookmarks/pages/add_bookmark/add_bookmark_page.dart';
import 'package:ez_bookmarks/pages/bookmark_list/components/logic_view_mix/drawer.dart';
import 'package:ez_bookmarks/riverpod/aspect/aspect_switcher.dart';
import 'package:ez_bookmarks/riverpod/axis_count/axis_count_switcher.dart';
import 'package:ez_bookmarks/riverpod/desc_or_asc/desc_or_asc_switcher.dart';
import 'package:ez_bookmarks/riverpod/sort_bookmarks/sort_kind_switcher.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ez_bookmarks/drift/database_1/database.dart';
import 'package:ez_bookmarks/riverpod/firebase_analytics/analytics.dart';

import 'package:ez_bookmarks/utils/various.dart';


class BookMarkList extends ConsumerStatefulWidget {
  const BookMarkList({
    super.key,
    required this.tags
  });

  final List<Tag>? tags;

  

  @override
  _BookMarkListState createState() => _BookMarkListState();
}

class _BookMarkListState extends ConsumerState<BookMarkList> {

  Widget? thumbnailImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  void dispose() {

    super.dispose();

  }


  @override
  Widget build(BuildContext context) {

    final analyticsProvider = ref.watch(analyticsNotifierProvider);

    final axisCount = ref.watch(axisCountSwitcherNotifierProvider);

    final aspectRatio = ref.watch(aspectSwitcherNotifierProvider);

    //final widthWatcher = ref.watch(screenWatcherNotifierProvider);

    final descOrAsc = ref.watch(descOrAscSwitcherNotifierProvider);

    final sortKind = ref.watch(sortKindSwitcherNotifierProvider);


    return Scaffold(
      appBar: widget.tags == null
        ? AppBar(
          title: const Text("ホーム"),
          actions: [

              IconButton(
                  onPressed: () async{
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddBookmarkPage(), // ImageDisplayに遷移
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                ),
              
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  if(context.mounted){
                    setState(() {});
                  }
                },
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  child: const Icon(Icons.more_vert),
                
                  onTapDown: (details){
                
                    //その場に表示するメニューを作成
                    final position = details.globalPosition;
                    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
                
                    final RelativeRect positionPopup = RelativeRect.fromLTRB(
                      position.dx,
                      position.dy,
                      overlay.size.width - position.dx,
                      overlay.size.height - position.dy,
                    );
                
                    showMenu(
                      context: context,
                      position: positionPopup,
                      items: [

                        PopupMenuItem(
                          child: ListTile(
                            leading: const Icon(Icons.grid_on),
                            title: const Text('グリッド変更'),
                            onTap: () async{
                              
                              await FirebaseAnalytics.instance.logEvent(
                                name: "グリッドを変更する",
                                parameters: <String, dynamic>{
                                  'button_name': 'example_button',
                                },
                              );

                              //ここでdialogを出して、縦横比とグリッド数を変更させる。

                              if(context.mounted){
                                Navigator.of(context).pop();

                                showSettingGridAndAspectDialog(context);
                              }

                            },
                          ),
                        ),


                        PopupMenuItem(
                          child: ListTile(
                            leading: const Icon(Icons.sort),
                            title: const Text('ソート'),
                            onTap: () async{
                              //ここでdialogを出して、縦横比とグリッド数を変更させる。

                              Navigator.of(context).pop();

                              showSettingSortDialog(context); 

                            },
                          ),
                        ),



                        PopupMenuItem(
                          child: ListTile(
                            leading: const Icon(Icons.help),
                            title: const Text('ヘルプ'),
                            onTap: () {
                              final analyticsNotifier = ref.read(analyticsNotifierProvider.notifier);

                              analyticsNotifier.onEventOccur("ヘルプボタンが押されました。");

                              /*
                              FirebaseAnalytics.instance.logEvent(
                                name: "push_help_button",
                                parameters: <String, dynamic>{
                                  'button_name': 'example_button',
                                },
                              );
                               */

                              Navigator.of(context).pop();
                
                            },
                          ),
                        ),
                      ],
                    );
                
                  },
                
                ),
              ),

          ],

          

          )

        : AppBar(
          //タップすると現在のタグ一覧が見れる。
          title: TextButton(
            onPressed: () async{
              //単純にwidget.tagsを表示するだけ。wrapの形とdialogの形で、

              showSelectedTagsDialog(context, widget.tags);

            },
            child: const Text(
              "選択したタグ"
            ),

          ),



          actions: [


            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                if(context.mounted){
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookMarkList(tags: null),
                    ),
                    
                    (_) => false
                  );
                }
              },
            ),

            
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                if(context.mounted){
                  setState(() {});
                }
              },
            ),

            

            Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  child: const Icon(Icons.more_vert),
                
                  onTapDown: (details){
                
                    //その場に表示するメニューを作成
                    final position = details.globalPosition;
                    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
                
                    final RelativeRect positionPopup = RelativeRect.fromLTRB(
                      position.dx,
                      position.dy,
                      overlay.size.width - position.dx,
                      overlay.size.height - position.dy,
                    );
                
                    showMenu(
                      context: context,
                      position: positionPopup,
                      items: [

                        PopupMenuItem(
                          child: ListTile(
                            leading: const Icon(Icons.grid_on),
                            title: const Text('グリッド変更'),
                            onTap: () async{

                              Navigator.of(context).pop();

                              showSettingGridAndAspectDialog(context);

                            },
                          ),
                        ),


                        PopupMenuItem(
                          child: ListTile(
                            leading: const Icon(Icons.sort),
                            title: const Text('ソート変更'),
                            onTap: () async{
                              //ここでdialogを出して、縦横比とグリッド数を変更させる。

                              Navigator.of(context).pop();

                              showSettingSortDialog(context); 

                            },
                          ),
                        ),



                        PopupMenuItem(
                          child: ListTile(
                            leading: const Icon(Icons.help),
                            title: const Text('ヘルプ'),
                            onTap: () {
                
                              Navigator.of(context).pop();
                
                            },
                          ),
                        ),
                      ],
                    );
                
                  },
                
                ),
              ),
          ],
        ),

        drawer: widget.tags == null
          ? const CustomDrawer()
          : null,
        

      body: Column(
        //中央ぞろえ
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: StreamBuilder<List<Bookmark>>(
              //ここでデータベースを使って更新を行う。
              /*
              stream: widget.tags == null
                ? myDatabase.watchBookmarks()
                : myDatabase.watchBookmarks(),
              
               */

              stream: widget.tags == null
                ? Stream.fromFuture(myDatabase.findBookmarksContainingAllTags([], sortKind, descOrAsc))
                : Stream.fromFuture(myDatabase.findBookmarksContainingAllTags(widget.tags!, sortKind, descOrAsc)),

              
                             
                
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final bookmarks = snapshot.data ?? [];
                
                return GridView.builder(
                  addAutomaticKeepAlives: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                    crossAxisCount: axisCount.when(
                      data: (axisCount) => axisCount,
                      error: (error, stackTrace) => SizeConfig.screenWidth! > 600 ? 4 : 2,
                      loading: () => SizeConfig.screenWidth! > 600 ? 4 : 2,
                    ),

                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,

                    childAspectRatio: aspectRatio.when(
                      data: (aspect) => aspect,
                      error: (error, stackTrace) => SizeConfig.screenWidth! > 600 ? 0.75 : 0.4,
                      loading: () => SizeConfig.screenWidth! > 600 ? 0.75 : 0.4,
                    ),
                    
                  ),
                  itemCount: bookmarks.length +  (bookmarks.length / 5).floor(),
                  itemBuilder: (context, index) {
                    

            
                    if(index % 6 != 5){
                      // 広告の数だけインデックスをずらす
                      int actualIndex = index - (index / 6).floor(); 
                      final bookmark = bookmarks[actualIndex];
                      final imagePath = bookmark.imagePath;

                      final imageWidget = FutureBuilder<Widget>(
                        future: loadImage(imagePath, bookmark.urlText),
                        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Container();  // データを待っている間はローディング表示
                          } else if (snapshot.hasError || !snapshot.hasData) {
                            return Image.asset("assets/images/no_image.png", fit: BoxFit.cover);  // エラー発生時のフォールバック
                          } else {
                            return snapshot.data!;  // 成功した場合、取得した画像を表示
                          }
                        },
                      );





                      //automatickeepalive
                      return BookmarkCard(bookmark: bookmark, imageWidget: imageWidget);
                  

                    }
                    else{
                      //ここに広告
                      return Container(
                        //height: SizeConfig.blockSizeVertical! * 10,
                        color: Colors.white,
                        //TODO Admob
                        child: InlineAdaptiveAdBanner(
                          requestId: "BOOKMARK", 
                          adHeight: SizeConfig.blockSizeVertical!.toInt() * 20,
                        ),

                        /*
                        
                        */
                      );

                    }
                  
                  },
                );
              },
            ),
          ),

          SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
        
          Container(
            height: SizeConfig.blockSizeVertical! * 10,
            color: Colors.white,
            //TODO Admob

            child: InlineAdaptiveAdBanner(
              requestId: "BOOKMARK", 
              adHeight: SizeConfig.blockSizeVertical!.toInt() * 10,
            ),

            /*
            
            */
          ),

          SizedBox(height: SizeConfig.blockSizeVertical! * 2,),
        ],
      ),
    );
  }

}






/*

/*
                          ? FutureBuilder(
                              future: fetchURLData(bookmark.urlText),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Container();
                                  
                                  //return CircularProgressIndicator();  // データを待っている間はローディング表示
                                } else if (snapshot.hasError) {
                                  
                                  return Image.file(File('assets/images/no_image.png'), fit: BoxFit.cover);  // エラー発生時のフォールバック
                                } else {
                                  if(snapshot.data == null){
                                    return Image.file(File('assets/images/no_image.png'), fit: BoxFit.cover);
                                  }
                                  return Image.network(
                                    snapshot.data,
                                    fit: BoxFit.cover,
                                  );  // 成功した場合、取得したURLで画像を表示
                                }
                              },
                            )
                           */
                          //: Image.asset('assets/images/no_image.png', fit: BoxFit.cover);
 */