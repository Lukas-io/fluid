import 'package:fluid/screens/music_post_screen.dart';
import 'package:fluid/widgets/fluid_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../models/post_model.dart';
import 'music_post_item_background.dart';
import 'music_post_item_content.dart';

import 'package:animations/animations.dart';

class MusicPostItem extends StatelessWidget {
  final PostModel post;

  const MusicPostItem(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return _MusicPostItemAnimated(post);
  }
}

class _MusicPostItemAnimated extends StatefulWidget {
  final PostModel post;

  const _MusicPostItemAnimated(this.post);

  @override
  State<_MusicPostItemAnimated> createState() => _MusicPostItemAnimatedState();
}

class _MusicPostItemAnimatedState extends State<_MusicPostItemAnimated> {
  VideoPlayerController _controller = VideoPlayerController.networkUrl(
    Uri.https("dummy, disregard this"),
  );

  @override
  void initState() {
    super.initState();

    if (widget.post.video != null) {
      WidgetsBinding.instance.deferFirstFrame();
      _controller = VideoPlayerController.asset(widget.post.video!)
        ..setLooping(true)
        ..setVolume(0);

      _controller.initialize().then((_) {
        _controller.play();
        WidgetsBinding.instance.allowFirstFrame();
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    if (widget.post.video != null) _controller.dispose();
    super.dispose();
  }

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
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: FluidWidget(
          transitionType: ContainerTransitionType.fadeThrough,
          transitionDuration: Duration(milliseconds: 500),
          color: widget.post.background,
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(24),
          ),
          openShape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(24),
          ),
          openBuilder: (context, _) =>
              MusicPostScreen(widget.post, controller: _controller),
          closedBuilder: (context, openContainer) => Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: MusicPostItemBackground(
                  widget.post,
                  controller: _controller,
                ),
              ),
              MusicPostItemContent(widget.post),
            ],
          ),
        ),
      ),
    );
  }
}
