import 'dart:ui';

import 'package:fluid/models/song_model.dart';

class PostModel {
  final String? video;
  final String? photo;
  final String profile;
  final String title;
  final String description;
  final String name;
  final String date;
  final Color background;

  final String duration;
  final String views;
  final List<SongModel> songs;

  const PostModel({
    this.video,
    this.photo,
    required this.profile,
    required this.description,
    required this.title,
    required this.name,
    required this.date,
    required this.duration,
    required this.background,
    required this.views,
    required this.songs,
  });
}
