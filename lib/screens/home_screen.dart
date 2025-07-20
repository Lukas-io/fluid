import 'package:fluid/models/post_data.dart';

import 'package:flutter/material.dart';

import '../widgets/fluid_app_bar.dart';
import '../widgets/music_post_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: FluidAppBar()),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final post = posts[index];
              return MusicPostItem(post);
            }, childCount: posts.length),
          ),
        ],
      ),
    );
  }
}
