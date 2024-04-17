/*
import 'package:ez_bookmarks/iroirotamesu/show_thumbnail.dart';
import 'package:flutter/material.dart';

class DummyPage extends StatefulWidget{
  const DummyPage({
    super.key,

  });

  @override
  _DummyPageState createState() => _DummyPageState();

}

class _DummyPageState extends State<DummyPage>{
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("ホーム"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              controller: _urlController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),

            ElevatedButton(
              onPressed : () async{
                //print(_urlController.text);
                Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ShowThumbnailWidget(url: _urlController.text)
                            ),
                          );
              }, 
              child: const Text("ここをタップす")
            )
            

          ],
        ),
      ),
    );

  }

}

 */