import 'package:fluid/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import '../core/assets.dart';
import 'mute_button.dart';

class MusicPostAppBarContent extends StatelessWidget {
  final PostModel post;
  final double shrinkOffset;

  const MusicPostAppBarContent(
    this.post, {
    super.key,
    required this.shrinkOffset,
  });

  double getSpacerSize() {
    double size = 270 - shrinkOffset;

    if (size < 0) size = 0;
    return size;
  }

  double getAvatarOpacity() => shrinkOffset > 290 ? 0 : 1;

  double getDateOpacity() => shrinkOffset > 250 ? 0 : 1;

  double getDescriptionOpacity() => shrinkOffset > 160 ? 0 : 1;

  double getButtonOpacity() => shrinkOffset > 100 ? 0 : 1;

  Offset translateName() {
    if (shrinkOffset <= 200) return Offset.zero;

    final t = ((shrinkOffset - 200) / 320).clamp(0.0, 1.0);

    final dx = 0 * t;
    final dy = -48.0 * t;

    return Offset(dx, dy);
  }

  Offset translateTitle() {
    if (shrinkOffset <= 200) return Offset.zero;

    final t = ((shrinkOffset - 200) / 320).clamp(0.0, 1.0);

    final dx = 48 * t;
    final dy = -80 * t;

    return Offset(dx, dy);
  }

  Offset translateStats() {
    if (shrinkOffset <= 200) return Offset.zero;

    final t = ((shrinkOffset - 200) / 320).clamp(0.0, 1.0);

    final dx = 32 * t;
    final dy = -77 * t;

    return Offset(dx, dy);
  }

  double getTitleSize() {
    double size = 32.0;
    if (shrinkOffset <= 200) return size;

    final t = ((shrinkOffset - 200) / 320).clamp(0.0, 1.0);

    size -= 10 * t;

    return size;
  }

  @override
  Widget build(BuildContext context) {
    Color grey = Colors.grey.shade700.withOpacity(0.7);

    return OverflowBar(
      overflowAlignment: OverflowBarAlignment.center,
      children: [
        AnimatedOpacity(
          opacity: getAvatarOpacity(),
          duration: 300.ms,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Hero(
                tag: "${post.id}${post.profile}",

                child: Container(
                  padding: EdgeInsets.all(3.0),
                  margin: EdgeInsets.all(2),
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
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Hero(
                    tag: "${post.id}circle",

                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      radius: 10,
                    ),
                  ),
                  Hero(
                    tag: "${post.id}${Assets.plus}",

                    child: SvgPicture.asset(
                      Assets.plus,
                      width: 10,
                      color: Colors.black.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12),

        Transform.translate(
          offset: translateName(),
          child: Hero(
            tag: "${post.id}${post.name}",

            child: Material(
              type: MaterialType.transparency,
              child: Text(
                post.name.toUpperCase(),

                style: TextStyle(
                  color: (post.invertTextColor ? Colors.black54 : Colors.white)
                      .withOpacity(0.9),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 0,
                  height: 0,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        AnimatedOpacity(
          opacity: getDateOpacity(),
          duration: 300.ms,
          child: Hero(
            tag: "${post.id}${post.date}",

            child: Material(
              type: MaterialType.transparency,

              child: Container(
                width: 50,
                clipBehavior: Clip.none,

                child: Text(
                  post.date,

                  style: TextStyle(
                    color: Colors.grey.shade600.withOpacity(0.6),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 20),
        Transform.translate(
          offset: translateTitle(),
          child: Hero(
            tag: "${post.id}${post.title}",
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                post.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontWeight: FontWeight.w600,
                  fontSize: getTitleSize(),
                ),
              ),
            ),
          ),
        ),

        Transform.translate(
          offset: translateStats(),
          child: Hero(
            tag: "${post.id}${post.views}",
            child: Material(
              type: MaterialType.transparency,
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
        SizedBox(height: 12),
        AnimatedOpacity(
          duration: 300.ms,
          opacity: getDescriptionOpacity(),
          child: Text(
            post.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: post.invertTextColor
                  ? Colors.white.withOpacity(0.85)
                  : Colors.grey.shade600,
              fontWeight: FontWeight.w500,

              fontSize: 18,
            ),
          ),
        ),
        SizedBox(height: getSpacerSize()),
        AnimatedOpacity(
          duration: 300.ms,
          opacity: getButtonOpacity(),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 24,
                children: [
                  Hero(
                    tag: "${post.id} button5",
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

                  Hero(
                    tag: "${post.id} button4",
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
                ],
              ),
              if (post.video != null)
                Positioned(
                  top: -40,
                  right: 25,
                  child: Hero(tag: "${post.id}mute", child: MuteButton()),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
