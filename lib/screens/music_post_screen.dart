import 'package:fluid/models/post_model.dart';
import 'package:flutter/material.dart';

import '../widgets/music_post_app_bar.dart';

class MusicPostScreen extends StatelessWidget {
  final PostModel post;

  const MusicPostScreen(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [SliverPersistentHeader(delegate: MusicPostAppBar(post))],
      ),
    );
  }
}
