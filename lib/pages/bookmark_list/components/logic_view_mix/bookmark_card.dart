import 'package:ez_bookmarks/database/drift/database_1/database.dart';
import 'package:ez_bookmarks/pages/bookmark_list/components/almost_logic/almost_logic.dart';
import 'package:ez_bookmarks/pages/bookmark_list/components/logic_view_mix/dialogs.dart';
import 'package:ez_bookmarks/pages/edit_bookmark/edit_bookmark_page.dart';
import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:ez_bookmarks/riverpod/desc_or_asc/desc_or_asc_switcher.dart';
import 'package:ez_bookmarks/riverpod/sort_bookmarks/sort_kind_switcher.dart';
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
  
  @override
  Widget build(BuildContext context) {

    final dbAd = ref.watch(dbAdminNotifierProvider);
    
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
                      widget.bookmark.content,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(formatCreatedAt(widget.bookmark.createdAt), style: const TextStyle(color: Colors.grey)),
                    Row(
                      children: [
                        const Icon(Icons.remove_red_eye),
                        Text('${widget.bookmark.watchNum}'),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
            title: const Text('説明'),
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
                title: const Text('タグ表示'),
                onTap: () async {
                  Navigator.of(context).pop();
                                        
                  Map<int,List<int>> sums = await calcSums(ref, context, widget.bookmark, widget.tags, sortKind, descOrAsc);
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
            title: const Text('編集'),
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
            title: const Text('削除'),
            onTap: () {
              Navigator.of(context).pop();
              showConfirmDialog(
                context, 
                  () async {
                  final dbAd = ref.watch(dbAdminNotifierProvider);
                  await dbAd.deleteBookmark(widget.bookmark);
                              
                  if(context.mounted){
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
