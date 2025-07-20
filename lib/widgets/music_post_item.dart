import 'package:flutter/material.dart';

import '../models/post_model.dart';
import 'music_post_item_background.dart';
import 'music_post_item_content.dart';

class MusicPostItem extends StatelessWidget {
  final PostModel post;

  const MusicPostItem(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.82,
      child: Container(
        margin: EdgeInsetsGeometry.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 0,
              blurRadius: 20,
              offset: Offset(4, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),

              child: MusicPostItemBackground(post),
            ),
            MusicPostItemContent(post),
          ],
        ),
      ),
    );
  }
}
