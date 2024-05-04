import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  final String content;
  final String title;

  const HelpPage({Key? key, required this.content, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        //ページを戻らない
        automaticallyImplyLeading: false,
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            //min
            mainAxisSize: MainAxisSize.min,
            children: [
              //Center(child: Text(content, style: TextStyle(fontSize: 16))),
              Text(content, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}