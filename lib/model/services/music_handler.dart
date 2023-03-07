import 'package:learn_music/model/enums/genre.dart';
import 'package:learn_music/model/raw_model/album.dart';
import 'package:learn_music/model/raw_model/artist.dart';
import 'package:learn_music/model/raw_model/song.dart';
import 'package:learn_music/model/services/music_datas.dart';

class MusicHandler {
  final datas = MusicDatas();

  List<Artist> allArtists() {
    List<Artist> artists = [];
    final all = datas.allDatas();
    for (var song in all) {
      if (!artists.contains(song.artist)) {
        artists.add(song.artist);
      }
    }
    return artists;
  }

  List<Album> allAlbums() {
    List<Album> albums = [];
    final all = datas.allDatas();
    for (var song in all) {
      final singer = song.artist.name;
      final albumTitle = song.album;
      Album newAlbum = albums.firstWhere(
          (album) => (album.artist.name == singer && album.title == albumTitle),
          orElse: () =>
              Album(artist: song.artist, title: song.album, songs: [song]));
      if (!newAlbum.songs.contains(song)) newAlbum.songs.add(song);
      if (!albums.contains(newAlbum)) albums.add(newAlbum);
    }
    return albums;
  }

  List<Genre> allGenres() {
    List<Genre> genres = [];
    final all = datas.allDatas();
    for (var song in all) {
      if (!genres.contains(song.genre)) genres.add(song.genre);
    }
    return genres;
  }

  List<Song> allMusicFromArtist(Artist artist) {
    List<Song> playlist = [];
    final all = datas.allDatas();
    for (var song in all) {
      if (song.artist.name == artist.name) {
        playlist.add(song);
      }
    }
    return playlist;
  }

  List<Song> allMusicFromGenre(Genre genre) {
    List<Song> playlist = [];
    final all = datas.allDatas();
    for (var song in all) {
      if (song.genre == genre) {
        playlist.add(song);
      }
    }
    return playlist;
  }

  List<Song> researche(String string) {
    final lowerCase = string.toLowerCase();
    final all = datas.allDatas();
    List<Song> result = [];
    for (var song in all) {
      final artist = song.artist.name.toLowerCase();
      final album = song.album.toLowerCase();
      final title = song.title.toLowerCase();
      if (artist.contains(lowerCase) ||
          album.contains(lowerCase) ||
          title.contains(lowerCase)) {
        result.add(song);
      }
    }
    return result;
  }
}
