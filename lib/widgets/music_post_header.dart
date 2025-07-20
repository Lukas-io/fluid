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
        Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.7), width: 2),
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            backgroundImage: Image.asset(post.profile).image,
            radius: 20,
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        ),
        Spacer(),
        IconButton.filled(
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          onPressed: () {},
          icon: SvgPicture.asset(
            Assets.plus,
            width: 18,
            color: Colors.black.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}
