import 'package:fluid/models/song_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/assets.dart';

class SongListItem extends StatelessWidget {
  final SongModel song;

  const SongListItem(this.song, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          spacing: 12,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: Image.asset(
                song.cover,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                  Text(
                    song.artist,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            Icon(CupertinoIcons.heart_fill, color: Colors.grey),

            SvgPicture.asset(Assets.details, width: 20, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
