import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_music/model/raw_model/album.dart';
import 'package:learn_music/model/services/music_handler.dart';
import 'package:learn_music/views/cells/album_view_cell.dart';

class AlbumsContainer extends StatelessWidget {
  final List<Album> albums = MusicHandler().allAlbums();

  AlbumsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Albums", style: GoogleFonts.signika(fontSize: 20)),
        SizedBox(
          height: 300,
          child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: albums.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: ((context, index) => AlbumViewCell(
                    album: albums[index],
                  ))),
        )
      ],
    );
  }
}
