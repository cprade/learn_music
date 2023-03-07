import 'package:flutter/material.dart';
import 'package:learn_music/views/list_containers/albums_container.dart';
import 'package:learn_music/views/list_containers/artist_container.dart';
import 'package:learn_music/views/list_containers/genres_container.dart';

class MusicView extends StatelessWidget {
  const MusicView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Divider(),
          //Container pour les artistes
          ArtistContainer(),
          const Divider(),
          //Container pour les Albums
          AlbumsContainer(),
          const Divider(),
          //Container pour les Genres de musique
          GenresContainer(),
          const Divider()
        ],
      ),
    );
  }
}
