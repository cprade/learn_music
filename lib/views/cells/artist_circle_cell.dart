import 'package:flutter/material.dart';
import 'package:learn_music/controller/playlist_controller.dart';
import 'package:learn_music/model/enums/playlist.dart';
import 'package:learn_music/model/raw_model/artist.dart';
import 'package:learn_music/model/services/music_handler.dart';

class ArtistCircleCell extends StatelessWidget {
 final Artist artist;
 final double height;
 const ArtistCircleCell({Key? key, required this.artist, required this.height}): super(key: key);

 @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final playlist = MusicHandler().allMusicFromArtist(artist);
        final route = MaterialPageRoute(builder: (context) => PlayListController(
            title: artist.name,
            playlist: playlist,
            type: Playlist.artist)
        );
        Navigator.push(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipOval(
          child: Image.network(artist.urlImage, width: height, height: height, fit: BoxFit.cover,)
        ),
      ),
    );
  }
}