import 'package:ez_bookmarks/database/drift/database_1/database.dart';
import 'package:ez_bookmarks/i18n/strings.g.dart';
import 'package:ez_bookmarks/pages/bookmark_list/components/almost_logic/almost_logic.dart';
import 'package:ez_bookmarks/pages/bookmark_list/components/bookmark_card/components/dialogs.dart';
import 'package:ez_bookmarks/pages/bookmark_list/components/logic_view_mix/dialogs.dart';
import 'package:ez_bookmarks/pages/edit_bookmark/edit_bookmark_page.dart';
import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:ez_bookmarks/riverpod/desc_or_asc/desc_or_asc_switcher.dart';
import 'package:ez_bookmarks/riverpod/local/language.dart';
import 'package:ez_bookmarks/riverpod/sort_bookmarks/sort_kind_switcher.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
// BookmarkCardウィジェット
class BookmarkCard extends ConsumerStatefulWidget {
  final Bookmark bookmark;
  final List<Tag>? tags;
  final Widget imageWidget;

  const BookmarkCard({
    super.key,
    required this.bookmark,
    required this.imageWidget,
    this.tags,
  });

  @override
  ConsumerState<BookmarkCard> createState() => _BookmarkCardState();
}

class _BookmarkCardState extends ConsumerState<BookmarkCard> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  String getFirstLine(String text) {
    // テキストを改行で分割し、最初の行のみを返す
    List<String> lines = text.split('\n');
    if (lines.isNotEmpty) {
      return lines.first;
    } else {
      return text;
    }
  }

  late String contentFirstLine;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    contentFirstLine = getFirstLine(widget.bookmark.content);


  }
  
  @override
  Widget build(BuildContext context) {

    final dbAd = ref.watch(dbAdminNotifierProvider);
    final translocations = Translations.of(context);
    
    super.build(context);

    return SizedBox(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () async {
            await dbAd.incrementWatchNum(widget.bookmark.id);
            await dbAd.updateUpdatedAtBookmark(widget.bookmark, DateTime.now());

            if (await canLaunchUrl(Uri.parse(widget.bookmark.urlText))) {
              await launchUrl(Uri.parse(widget.bookmark.urlText));
            }
          },
          child: Column(
            children: [
              Expanded(child: widget.imageWidget),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //widget.bookmark.content,
                      contentFirstLine,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    /*
                    Text(formatCreatedAt(widget.bookmark.createdAt), style: const TextStyle(color: Colors.grey)),
                    Row(
                      children: [
                        const Icon(Icons.remove_red_eye),
                        Text('${widget.bookmark.watchNum}'),
                      ],
                    ),
                     */
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Text(formatCreatedAt(widget.bookmark.createdAt), style: const TextStyle(color: Colors.grey)),
                  
                  SizedBox(width: SizeConfig.blockSizeHorizontal!*2,),
                  //const Icon(Icons.remove_red_eye),
                  //Text('${widget.bookmark.watchNum}'),

                  //SizedBox(width: SizeConfig.blockSizeHorizontal!*8,),

                  _buildPopupMenu(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopupMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        child: const Icon(Icons.more_vert),
        onTapDown: (details) => _showPopupMenu(context, details),
      ),
    );
  }

















  void _showPopupMenu(BuildContext context, TapDownDetails details) {

    final translocations = Translations.of(context);
    print(translocations.locales);
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
      items: <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.file_present),
            
            title: Text(translocations.bookmark_card.setting_list.explain),
            onTap: () {
              showDetailDialog(context, widget.bookmark.content, widget.bookmark.tags!);
            },
          ),
        ),
        PopupMenuItem(
          child: Consumer(
            builder: (context, ref, child) {
              final sortKind = ref.watch(sortKindSwitcherNotifierProvider);
              final descOrAsc = ref.watch(descOrAscSwitcherNotifierProvider);
              return ListTile(
                leading: const Icon(Icons.sell),
                title: Text(translocations.bookmark_card.setting_list.show_tags),
                onTap: () async {
                  Navigator.of(context).pop();
                                        
                  Map<int,List<int>> sums = await calcSums(ref, context, widget.bookmark, widget.tags, sortKind, descOrAsc);
                  print("ここでテストを ${widget.tags}");
                  if(context.mounted){
                    showBookmarkTagsDialog(ref, context, widget.bookmark, sums[0]!, sums[1]!, widget.tags);
                  }

                },
              );
            },
          )
        ),


        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.edit),
            title: Text(translocations.bookmark_card.setting_list.edit),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditBookmarkPage(bookmark: widget.bookmark),
              ));
            },
          ),
        ),


        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.delete),
            title: Text(translocations.bookmark_card.setting_list.delete),
            onTap: () {
              Navigator.of(context).pop();
              showDeleteConfirmDialog(
                context, 
                  () async {
                  final dbAd = ref.watch(dbAdminNotifierProvider);
                  await dbAd.deleteBookmark(widget.bookmark);

                  //TODO 削除したとき
                              
                  if(context.mounted){
                    //context.showSuccessSnackBar(message: "削除しました。");
                    context.showSuccessSnackBar(message: translocations.bookmark_card.setting_list.delete_dialog.snackbar.delete);
                    Navigator.pop(context);
                  } // Close the dialog
  
  
                }
              );
            },
          ),
        ),
      ],
    );
  }
}
