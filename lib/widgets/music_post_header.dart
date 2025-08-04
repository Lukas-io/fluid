import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/assets.dart';
import '../models/post_model.dart';

class MusicPostHeader extends StatelessWidget {
  final PostModel post;

  const MusicPostHeader(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Hero(
          tag: "${post.id}${post.profile}",
          child: Container(
            padding: EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(0.7),
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundImage: Image.asset(post.profile).image,
              radius: 20,
            ),
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "${post.id}${post.name}",

              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  width: 120,

                  child: Text(
                    post.name.toUpperCase(),
                    maxLines: null,
                    style: TextStyle(
                      color:
                          (post.invertTextColor ? Colors.black54 : Colors.white)
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
            Hero(
              tag: "${post.id}${post.date}",
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  width: 50,

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
          ],
        ),
        Spacer(),
        Stack(
          alignment: Alignment.center,
          children: [
            Hero(
              tag: "${post.id}circle",

              child: CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                radius: 20,
              ),
            ),
            Hero(
              tag: "${post.id}${Assets.plus}",

              child: SvgPicture.asset(
                Assets.plus,
                width: 18,
                color: Colors.black.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
