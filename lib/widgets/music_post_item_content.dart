import 'package:fluid/widgets/mute_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/assets.dart';
import '../models/post_model.dart';
import 'music_post_header.dart';

class MusicPostItemContent extends StatelessWidget {
  final PostModel post;

  const MusicPostItemContent(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    Color grey = Colors.grey.shade700.withOpacity(0.7);

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 24, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MusicPostHeader(post),
          SizedBox(height: 20),
          Hero(
            tag: "${post.id}${post.title}",
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                alignment: Alignment.center,
                width: 310,

                child: Text(
                  post.title,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ),
          Hero(
            tag: "${post.id}${post.views}",
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                alignment: Alignment.center,
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.leaderboard, color: grey, size: 16),
                    SizedBox(width: 4),
                    Text(
                      post.views,
                      style: TextStyle(
                        color: grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "  •  ",
                      style: TextStyle(
                        color: grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.timer_sharp, color: grey, size: 16),
                    SizedBox(width: 4),
                    Text(
                      post.duration,
                      style: TextStyle(
                        color: grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 24,
                children: [
                  Expanded(
                    child: Hero(
                      tag: "${post.id} button5",
                      child: Opacity(
                        opacity: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.3),
                          radius: 20,
                          child: Icon(
                            Icons.download,
                            color: Colors.grey.shade300,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Hero(
                    tag: "${post.id} button1",
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.3),
                      radius: 20,

                      child: SvgPicture.asset(
                        Assets.remove,
                        width: 20,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),

                  Hero(
                    tag: "${post.id} button2",
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 32,

                      child: SvgPicture.asset(
                        Assets.play,
                        width: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Hero(
                    tag: "${post.id} button3",
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.3),
                      radius: 20,
                      child: Icon(
                        Icons.thumb_up_off_alt_rounded,
                        color: Colors.grey.shade300,
                        size: 19,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Hero(
                      tag: "${post.id} button4",
                      child: Opacity(
                        opacity: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.3),
                          radius: 20,
                          child: SvgPicture.asset(
                            Assets.details,
                            width: 20,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (post.video != null)
                Hero(tag: "${post.id}mute", child: MuteButton()),
            ],
          ),
        ],
      ),
    );
  }
}
