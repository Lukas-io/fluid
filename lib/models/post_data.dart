import 'package:fluid/core/assets.dart';
import 'package:fluid/models/post_model.dart';
import 'package:fluid/models/song_model.dart';
import 'package:flutter/material.dart';

final List<SongModel> firstSongs = [
  SongModel(name: "name", artist: "artist", cover: "cover"),
];
final List<SongModel> secondSongs = [
  SongModel(name: "name", artist: "artist", cover: "cover"),
];
final List<SongModel> thirdSongs = [
  SongModel(name: "name", artist: "artist", cover: "cover"),
];

final List<PostModel> posts = [
  PostModel(
    profile: Assets.profile3,
    video: Assets.post1,
    description:
        "The music of the 1980's remains a tribute to glorious excess and left us with some huge tunes. Celebrate them here.",
    title: "80s Smash Hits",
    name: "Perfect Oldies",
    date: "July 2025",
    duration: "5h 35m",
    views: "9,543",
    songs: firstSongs,
    background: Colors.black,
  ),
  PostModel(
    profile: Assets.profile3,
    photo: Assets.post2,
    description:
        "The music of the 1980's remains a tribute to glorious excess and left us with some huge tunes. Celebrate them here.",
    title: "Cinematic Ambient",
    name: "Ambient Universe",
    date: "July 2025",
    duration: "5h 35m",
    views: "9,543",
    songs: secondSongs,
    textColor: Colors.black54,
    background: Color(0XFFEFAB25),
  ),
  PostModel(
    profile: Assets.profile3,
    photo: Assets.post3,
    description:
        "Beautiful, dreamy and dramatic instrumental neo classical piano scores from movies and tv series.",
    title: "Cinematic Piano",
    name: "Piano Daily",
    date: "July 2025",
    duration: "5h 35m",
    views: "9,543",
    songs: thirdSongs,
    background: Color(0XFF141414),
  ),
];
