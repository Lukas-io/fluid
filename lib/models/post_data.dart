import 'package:fluid/core/assets.dart';
import 'package:fluid/models/post_model.dart';
import 'package:fluid/models/song_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

final List<SongModel> songs = [
  SongModel(
    title: 'Bloodline',
    artist: 'Alex Warren',
    cover: Assets.alexwarrenBloodline,
  ),
  SongModel(
    title: 'Ordinary',
    artist: 'Alex Warren',
    cover: Assets.alexwarrenOrdinary,
  ),
  SongModel(
    title: 'Beautiful Things',
    artist: 'Benson Boone',
    cover: Assets.bensonbooneBeautifulthings,
  ),
  SongModel(
    title: 'Birds of a Feather',
    artist: 'Billie Eilish',
    cover: Assets.billieEilishBirdsofafeather,
  ),
  SongModel(title: 'Outside', artist: 'Cardi B', cover: Assets.cardiBOutside),
  SongModel(
    title: 'Pink Pony Club',
    artist: 'Chappell Roan',
    cover: Assets.chappellroanPinkponyclub,
  ),
  SongModel(title: 'Drake', artist: 'Drake', cover: Assets.drake),
  SongModel(
    title: 'What Did I Miss X',
    artist: 'Drake',
    cover: Assets.drakeWhatdidimissX,
  ),
  SongModel(title: 'Typa', artist: 'Glorilla', cover: Assets.glorillaTypa),
  SongModel(title: 'Golden', artist: 'Huntrx', cover: Assets.huntrxGolden),
  SongModel(title: 'Folded', artist: 'Kehlani', cover: Assets.kehlaniFolded),
  SongModel(
    title: 'Die With A Smile',
    artist: 'Lady Gaga',
    cover: Assets.ladyGagaDiewithasmile,
  ),
  SongModel(title: 'Mutt', artist: 'Leon Thomas', cover: Assets.leonthomasMutt),
  SongModel(
    title: '6 Months Later',
    artist: 'Megan Moroney',
    cover: Assets.meganmoroney6monthslater,
  ),
  SongModel(
    title: 'Morgan Wallen',
    artist: 'Morgan Wallen',
    cover: Assets.morganWallen,
  ),
  SongModel(
    title: 'Just In Case',
    artist: 'Morgan Wallen',
    cover: Assets.morganWallenJustincase,
  ),
  SongModel(
    title: 'I Had Some Help',
    artist: 'Post Malone',
    cover: Assets.postMaloneIhadsomehelp,
  ),
  SongModel(
    title: 'Love Me Not',
    artist: 'Ravyn Lenae',
    cover: Assets.ravynlenaeLovemenot,
  ),
  SongModel(
    title: 'Happen To Me',
    artist: 'Russell Dickerson',
    cover: Assets.russellDickersonHappentome,
  ),
  SongModel(
    title: 'Espresso',
    artist: 'Sabrina Carpenter',
    cover: Assets.sabrinaCarpenterEspresso,
  ),
  SongModel(
    title: 'Manchild',
    artist: 'Sabrina Carpenter',
    cover: Assets.sabrinaCarpenterManchild,
  ),
  SongModel(title: 'Sam Barber', artist: 'Sam Barber', cover: Assets.sambarber),
  SongModel(title: 'Shaboozey', artist: 'Shaboozey', cover: Assets.shaboozey),
  SongModel(
    title: 'A Bar Song (Tipsy)',
    artist: 'Shaboozey',
    cover: Assets.shaboozeyAbarsongtipsy,
  ),
  SongModel(
    title: 'Lose Control',
    artist: 'Teddy Swims',
    cover: Assets.teddyswimsLosecontrol,
  ),
];

final _random = Random();

List<SongModel> pickRandomSongs(int count) {
  final shuffled = List<SongModel>.from(songs)..shuffle(_random);
  return shuffled.take(count).toList();
}

final List<PostModel> posts = [
  PostModel(
    id: "Madonna",
    profile: Assets.profile3,
    video: Assets.post1,
    description:
        "The music of the 1980's remains a tribute to glorious excess and left us with some huge tunes. Celebrate them here.",
    title: "80s Smash Hits",
    name: "Perfect Oldies",
    date: "July 2025",
    duration: "5h 35m",
    views: "9,543",
    songs: pickRandomSongs(12),
    background: Colors.black,
  ),
  PostModel(
    id: "OrangeLady",
    profile: Assets.profile3,
    photo: Assets.post2,
    description:
        "The music of the 1980's remains a tribute to glorious excess and left us with some huge tunes. Celebrate them here.",
    title: "Cinematic Ambient",
    name: "Ambient Universe",
    date: "July 2025",
    duration: "5h 35m",
    views: "9,543",
    songs: pickRandomSongs(12),
    invertTextColor: true,
    background: Color(0XFFEFAB25),
  ),
  PostModel(
    id: "Pianist",
    profile: Assets.profile3,
    photo: Assets.post3,
    description:
        "Beautiful, dreamy and dramatic instrumental neo classical piano scores from movies and tv series.",
    title: "Cinematic Piano",
    name: "Piano Daily",
    date: "July 2025",
    duration: "5h 35m",
    views: "9,543",
    songs: pickRandomSongs(12),
    background: Color(0XFF141414),
  ),
];
