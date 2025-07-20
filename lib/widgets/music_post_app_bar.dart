import 'package:fluid/core/assets.dart';
import 'package:fluid/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'mute_button.dart';

class MusicPostAppBar extends SliverPersistentHeaderDelegate {
  final PostModel post;

  const MusicPostAppBar(this.post);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    Color grey = Colors.grey.shade700.withOpacity(0.7);

    return Container(
      height: maxExtent,
      padding: EdgeInsetsGeometry.symmetric(horizontal: 28),
      color: post.background,

      child: SafeArea(
        top: true,
        bottom: false,
        child: Stack(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios_new),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: EdgeInsets.all(3.0),
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withOpacity(0.7),
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundImage: Image.asset(
                          post.profile,
                          height: 1000,
                          fit: BoxFit.fitHeight,
                        ).image,
                        radius: 20,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      radius: 10,
                      child: SvgPicture.asset(
                        Assets.plus,
                        width: 10,
                        color: Colors.black.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8),
                Text(
                  post.name.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: -0.2,
                    height: 0,
                  ),
                ),
                Text(
                  post.date,
                  style: TextStyle(
                    color: Colors.grey.shade600,

                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 20),
                Text(
                  post.title,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
                Row(
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
                Spacer(),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 24,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.3),
                          radius: 20,

                          child: SvgPicture.asset(
                            Assets.remove,
                            width: 20,
                            color: Colors.grey.shade300,
                          ),
                        ),

                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 32,

                          child: SvgPicture.asset(
                            Assets.play,
                            width: 18,
                            color: Colors.black,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.3),
                          radius: 20,
                          child: Icon(
                            Icons.thumb_up_off_alt_rounded,
                            color: Colors.grey.shade300,
                            size: 19,
                          ),
                        ),
                      ],
                    ),
                    if (post.video != null) MuteButton(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 700;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return maxExtent != oldDelegate.maxExtent ||
        minExtent != oldDelegate.minExtent;
  }
}
