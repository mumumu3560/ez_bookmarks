



/*

void showBookmarkSettings(TapDownDetails details, BuildContext context) {
//その場に表示するメニューを作成
    final position = details.globalPosition;
    final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;

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
            leading: Icon(Icons.file_present),
            title: Text('説明'),
            onTap: () {

              Navigator.of(context).pop();

              

              showDetailDialog(context, bookmark.content, bookmark.tags!);


              
            },
          ),
        ),


        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.sell),
            title: Text('タグ表示'),
            onTap: () async{

              Navigator.of(context).pop();

              Map<int,List<int>> sums = await calcSums(context, bookmark, widget.tags, sortKind, descOrAsc);
              if(context.mounted){
                showBookmarkTagsDialog(context, bookmark, sums[0]!, sums[1]!, widget.tags);
              }

            },
          ),
        ),




        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('編集'),
            onTap: () {

              Navigator.of(context).pop();


              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditBookmarkPage(bookmark: bookmark),
                )
              );
            },
          ),
        ),




        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('削除'),
            onTap: () {
              showConfirmDialog(
              context, 
                () async {
                await myDatabase.deleteBookmark(bookmark);
                            
                if(context.mounted){
                  Navigator.pop(context);
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
 */