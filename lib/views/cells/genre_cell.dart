import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_music/controller/playlist_controller.dart';
import 'package:learn_music/model/enums/genre.dart';
import 'package:learn_music/model/enums/playlist.dart';
import 'package:learn_music/model/services/music_handler.dart';

class GenreCell extends StatelessWidget {
  final Genre genre;

  const GenreCell({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          final list = MusicHandler().allMusicFromGenre(genre);
          final route = MaterialPageRoute(builder: (context) {
            return PlayListController(
                title: genre.name, playlist: list, type: Playlist.genre);
          });
          Navigator.push(context, route);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color.fromRGBO(Random().nextInt(256),
                  Random().nextInt(256), Random().nextInt(256), 1)),
          child: Center(
            child: Text(
              genre.name,
              style: GoogleFonts.signika(fontSize: 20, color: Colors.blueGrey),
            ),
          ),
        ));
  }
}
