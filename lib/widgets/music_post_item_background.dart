import 'package:fluid/models/post_model.dart';
import 'package:fluid/widgets/bottom_gradient_overlay.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MusicPostItemBackground extends StatelessWidget {
  final PostModel post;
  final double height;
  final Offset translate;
  final bool showColor;
  final VideoPlayerController? controller;

  const MusicPostItemBackground(
    this.post, {
    super.key,
    this.height = 280,
    this.translate = Offset.zero,
    required this.controller,
    this.showColor = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = showColor ? post.background : Colors.transparent;
    return Container(
      color: color,
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: height,
        child: Hero(
          tag: "${post.id}${post.video ?? post.photo}",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Transform.translate(
                  offset: translate,
                  child: post.video != null
                      ? VideoPlayer(controller!)
                      : Image.asset(post.photo ?? "", fit: BoxFit.fitHeight),
                ),
                BottomGradientOverlay(color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
