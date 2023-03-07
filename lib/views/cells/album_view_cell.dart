import 'package:flutter/material.dart';
import 'package:learn_music/controller/playlist_controller.dart';
import 'package:learn_music/model/enums/playlist.dart';
import 'package:learn_music/model/raw_model/album.dart';

class AlbumViewCell extends StatelessWidget {
  final Album album;
  const AlbumViewCell({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PlayListController(
                title: album.title,
                playlist: album.songs,
                type: Playlist.album);
          }));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(album.songs[0].thumb, fit: BoxFit.cover),
        ));
  }
}
