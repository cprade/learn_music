import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_music/model/enums/genre.dart';
import 'package:learn_music/model/services/music_handler.dart';
import 'package:learn_music/views/cells/genre_cell.dart';

class GenresContainer extends StatelessWidget {
  final List<Genre> genres = MusicHandler().allGenres();

  GenresContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Genres musicaux",
          style: GoogleFonts.signika(fontSize: 20),
        ),
        SizedBox(
          height: 75,
          child: ListView.builder(
              itemCount: genres.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) =>
                  GenreCell(genre: genres[index]))),
        )
      ],
    );
  }
}
