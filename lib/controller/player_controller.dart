import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:learn_music/model/enums/media_type.dart';
import 'package:learn_music/model/raw_model/song.dart';
import 'package:learn_music/views/player_view.dart';

class MyPlayerController extends StatefulWidget {
  final Song songToPlay;
  final List<Song> playlist;
  final Color backgroundColor;

  const MyPlayerController(
      {super.key,
      required this.songToPlay,
      required this.playlist,
      required this.backgroundColor});
  @override
  MyPlayerControllerState createState() => MyPlayerControllerState();
}

class MyPlayerControllerState extends State<MyPlayerController> {
  late Song song;
  late AudioPlayer audioPlayer;
  AudioCache? audioCache;
  Duration position = const Duration(seconds: 0);
  Duration maxDuration = const Duration(seconds: 0);
  bool playShuffle = false;
  bool repeat = false;
  IconData iconData = Icons.play_circle;

  @override
  void initState() {
    super.initState();
    song = widget.songToPlay;
    setupPlayer();
  }

  @override
  void dispose() {
    clearPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PlayerView(
        song: song,
        onRepeatPressed: onRepeatPressed,
        onShufflePressed: onShufflePressed,
        onRewindPressed: onRewindPressed,
        onPlayPausePressed: onPlayPausePressed,
        onForwardPressed: onForwardPressed,
        onPositionChanged: onPositionChanged,
        position: position,
        maxDuration: maxDuration,
        repeat: repeat,
        shuffle: playShuffle,
        playPauseIcon: iconData,
        backgroundColor: widget.backgroundColor,
      );

  onPositionChanged(double newPosition) {
    final newDuration = Duration(seconds: newPosition.toInt());
    audioPlayer.seek(newDuration);
  }

  onPlayPausePressed() async {
    final state = audioPlayer.state;
    switch (state) {
      case PlayerState.COMPLETED:
        (repeat)
            ? audioPlayer.seek(const Duration(seconds: 0))
            : onForwardPressed();
        break;
      case PlayerState.STOPPED:
        setupPlayer();
        break;
      case PlayerState.PLAYING:
        await audioPlayer.pause();
        break;
      case PlayerState.PAUSED:
        await audioPlayer.resume();
        break;
    }
  }

  onRewindPressed() {
    final newSong = (playShuffle) ? randomSong() : previousSong();
    song = newSong;
    clearPlayer();
    setupPlayer();
  }

  onForwardPressed() {
    final newSong = (playShuffle) ? randomSong() : nextSong();
    song = newSong;
    clearPlayer();
    setupPlayer();
  }

  onRepeatPressed() {
    setState(() {
      repeat = !repeat;
    });
  }

  onShufflePressed() {
    setState(() {
      playShuffle = !playShuffle;
    });
  }

  Future<String> pathForInApp() async {
    String string = "";
    audioCache = AudioCache();
    if (audioCache != null) {
      final uri = await audioCache!.load(song.path);
      string = uri.toString();
      return string;
    } else {
      return string;
    }
  }

  onStateChange(PlayerState state) {
    setState(() {
      switch (state) {
        case PlayerState.PLAYING:
          iconData = Icons.pause_circle;
          break;
        case PlayerState.PAUSED:
          iconData = Icons.play_circle;
          break;
        case PlayerState.COMPLETED:
          break;
        case PlayerState.STOPPED:
          iconData = Icons.play_circle;
      }
    });
  }

  onDurationChange(Duration duration) {
    setState(() {
      maxDuration = duration;
    });
  }

  onAudioPositionChanged(Duration newPosition) {
    setState(() {
      position = newPosition;
    });
  }

  setupPlayer() async {
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen(onStateChange);
    audioPlayer.onDurationChanged.listen(onDurationChange);
    audioPlayer.onAudioPositionChanged.listen(onAudioPositionChanged);
    final url = (song.mediaType == MediaType.internet)
        ? song.path
        : await pathForInApp();
    await audioPlayer.play(url);
  }

  clearPlayer() {
    audioPlayer.stop();
    audioPlayer.dispose();
    if (audioCache != null) audioCache?.clearAll();
    audioCache = null;
  }

  Song previousSong() {
    final index =
        widget.playlist.indexWhere((song) => song.title == this.song.title);
    final newIndex = (index == 0) ? widget.playlist.length - 1 : index - 1;
    return widget.playlist[newIndex];
  }

  Song nextSong() {
    final index =
        widget.playlist.indexWhere((song) => song.title == this.song.title);
    final int newIndex = (index < widget.playlist.length - 1) ? index + 1 : 0;
    return widget.playlist[newIndex];
  }

  Song randomSong() {
    final int index = Random().nextInt(widget.playlist.length);
    final newSong = widget.playlist[index];
    return newSong;
  }
}
