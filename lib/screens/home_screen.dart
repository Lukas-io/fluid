import 'package:fluid/models/post_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/fluid_app_bar.dart';
import '../widgets/music_post_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
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
            SliverToBoxAdapter(child: SafeArea(top: false, child: SizedBox())),
          ],
        ),
      ),
    );
  }
}
