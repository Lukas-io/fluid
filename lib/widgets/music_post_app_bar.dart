import 'package:fluid/models/post_model.dart';
import 'package:fluid/widgets/music_post_app_bar_content.dart';
import 'package:fluid/widgets/music_post_item_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MusicPostAppBar extends SliverPersistentHeaderDelegate {
  final PostModel post;
  final VideoPlayerController? controller;

  const MusicPostAppBar(this.post, {required this.controller});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    double getImageHeight() {
      double size = 350;
      if (shrinkOffset >= 520) {
      } else if (shrinkOffset >= 300) {
        size -= (shrinkOffset - 300) / 2.75 + 150;
      } else if (shrinkOffset >= 150) {
        size -= 150;
      } else if (shrinkOffset <= 150) {
        size -= shrinkOffset;
      }

      return size;
    }

    Offset translateImage() {
      if (shrinkOffset <= 200) return Offset.zero;

      final t = ((shrinkOffset - 200) / 320).clamp(0.0, 1.0);

      final dx = -100 * t;
      final dy = 0.0;

      return Offset(dx, dy);
    }

    return Container(
      height: maxExtent,
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      color: post.background,

      child: SafeArea(
        top: true,
        bottom: false,
        child: Stack(
          children: [
            MusicPostItemBackground(
              post,
              controller: controller,
              height: getImageHeight(),
              translate: translateImage(),
            ),
            MusicPostAppBarContent(post, shrinkOffset: shrinkOffset),

            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: CupertinoColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 700;

  @override
  double get minExtent => 180;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return maxExtent != oldDelegate.maxExtent ||
        minExtent != oldDelegate.minExtent;
  }
}
