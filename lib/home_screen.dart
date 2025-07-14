import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.more)),
        title: Row(children: [Text("Featured"), Icon(Icons.arrow_drop_down)]),
        actions: [
          Icon(Icons.table_rows),
          Icon(Icons.rectangle),
          Icon(CupertinoIcons.search),
        ],
      ),
      body: SingleChildScrollView(child: Column(children: [MusicPostItem()])),
    );
  }
}

class MusicPostItem extends StatelessWidget {
  const MusicPostItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(children: []),
    );
  }
}

class MusicPostHeader extends StatelessWidget {
  const MusicPostHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
