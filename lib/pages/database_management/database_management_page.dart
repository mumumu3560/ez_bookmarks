import 'package:ez_bookmarks/admob/inline_adaptive_banner.dart';
import 'package:ez_bookmarks/pages/database_management/components/almost_logic/almost_logic.dart';
import 'package:ez_bookmarks/pages/database_management/components/almost_view/dialogs.dart';
import 'package:ez_bookmarks/riverpod/db_switcher/db_switcher.dart';
import 'package:flutter/material.dart';
import 'package:ez_bookmarks/utils/various.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class DatabaseManagementPage extends ConsumerWidget {
  const DatabaseManagementPage({super.key});
  

 @override
Widget build(BuildContext context, WidgetRef ref) {

  final dbSwitcher = ref.watch(dbSwitcherNotifierProvider);

  return Scaffold(
    appBar: AppBar(
      title: const Text('データベース管理'),
    ),
    body: Column(
      children: [
        Expanded(
          child: SafeArea(
            child: SingleChildScrollView( // Allows the page to be scrollable
              padding: const EdgeInsets.all(20.0), // Adds padding around the content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Aligns text to the start of the app
                children: <Widget>[

                  
                  Row(
                    children: [
                      Text(
                        'インポートについて',
                        style: Theme.of(context).textTheme.titleLarge
                      ),
            
                      IconButton(
                        //onPressed: () => showImportHelpDialog(context),
                        onPressed: () => showImportHelpDialog(context),
                        icon: const Icon(Icons.help)
                      )
                    ],
                  ),
            
                  ElevatedButton(                    

                    onPressed: (){
                      
                      importDatabase(ref,context, dbSwitcher); 
                    } ,

                    child: const Text("インポートする")
                  ),
            
            
                  Row(
                    children: [
                      Text(
                        'バックアップについて',
                        style: Theme.of(context).textTheme.titleLarge
                      ),
                      IconButton(
                        onPressed: () async{
                          //showBackupHelpDialog(context);
                          showBackupHelpDialog(context);
                        } , 
                        icon: const Icon(Icons.help)
                      )
                    ],
                  ),
            
                  ElevatedButton(
                    onPressed: (){
                      backupDatabase(ref,context, dbSwitcher);
                    }, 
                    child: const Text("バックアップする")
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
            child: InlineAdaptiveAdBanner(
              requestId: "IMPORT", 
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
