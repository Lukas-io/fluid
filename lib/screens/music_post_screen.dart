import 'package:fluid/models/post_model.dart';
import 'package:fluid/widgets/song_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../widgets/music_post_app_bar.dart';

class MusicPostScreen extends StatelessWidget {
  final PostModel post;
  final VideoPlayerController? controller;

  const MusicPostScreen(this.post, {super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: MusicPostAppBar(post, controller: controller),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final song = post.songs[index];
                return SongListItem(song);
              }, childCount: post.songs.length),
            ),
            SliverToBoxAdapter(child: SafeArea(top: false, child: SizedBox())),
          ],
        ),
      ),
    );
  }
}
