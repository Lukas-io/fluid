import 'package:fluid/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MusicPostItemBackground extends StatefulWidget {
  final PostModel post;

  const MusicPostItemBackground(this.post, {super.key});

  @override
  State<MusicPostItemBackground> createState() =>
      _MusicPostItemBackgroundState();
}

class _MusicPostItemBackgroundState extends State<MusicPostItemBackground> {
  late VideoPlayerController _controller;

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
    return Stack(
      children: [
        Container(
          color: widget.post.background,

          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 300,

            // width: double.infinity,
            child: widget.post.video != null
                ? VideoPlayer(_controller)
                : Image.asset(widget.post.photo ?? "", fit: BoxFit.cover),
          ),
        ),
        _buildGradient(widget.post.background),
      ],
    );
  }

  Widget _buildGradient(Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.center,
          colors: [color, Colors.transparent],
        ),
      ),
    );
  }
}
