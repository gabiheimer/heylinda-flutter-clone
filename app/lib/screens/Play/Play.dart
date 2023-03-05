import 'dart:io';
import 'dart:math';

import 'package:app/data/meditations.dart';
import 'package:app/storage/Storage.dart';
import 'package:app/utils/meditationUtils.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../styles/Colors.dart';
import '../../widgets/FavouriteButton.dart';
import 'PlayerControls.dart';

class Play extends StatefulWidget {
  const Play({
    super.key,
    required this.meditation,
    required this.updateFavourites,
  });

  final Meditation meditation;
  final void Function(Meditation) updateFavourites;

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  bool isFavourited = false;
  AudioPlayer? audioPlayer;
  bool isLoadingAudio = true;
  bool isPlaying = false;
  int positionMillis = 0;
  int durationMillis = 0;

  void initStorage() async {
    bool storageValue = await Storage.isFavourite(widget.meditation.id);
    setState(() {
      isFavourited = storageValue;
    });
  }

  void initMeditationAudio() async {
    audioPlayer = AudioPlayer();
    String filePath = await getMeditationFilePath(widget.meditation.uri);
    bool fileExists = await File(filePath).exists();

    if (fileExists) {
      audioPlayer?.setUrl(filePath, isLocal: true);
    } else {
      audioPlayer?.setUrl(widget.meditation.uri, isLocal: false);
    }

    audioPlayer?.onAudioPositionChanged.listen((Duration duration) {
      setState(() => positionMillis = duration.inMilliseconds);
    });

    audioPlayer?.onDurationChanged.listen((Duration duration) {
      setState(() => durationMillis = duration.inMilliseconds);
    });

    audioPlayer?.onPlayerCompletion.listen((_) {
      setState(() {
        positionMillis = durationMillis;
        isPlaying = false;
      });

      final DateTime now = DateTime.now();
      final DateTime today = DateTime(now.year, now.month, now.day);
      Storage.updateActivity(today, durationMillis);
    });
  }

  @override
  void initState() {
    initStorage();
    initMeditationAudio();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer?.release();
    super.dispose();
  }

  void onFavourite() {
    Storage.updateFavourites(widget.meditation.id);
    setState(() {
      isFavourited = !isFavourited;
      widget.updateFavourites(widget.meditation);
    });
  }

  String _formatToString(int n) {
    return n < 10 ? '0$n' : n.toString();
  }

  String _msToTime(int s) {
    int ms = s % 1000;
    s = ((s - ms) / 1000).floor();
    int secs = s % 60;
    s = ((s - secs) / 60).floor();
    int mins = s % 60;
    String minsString = _formatToString(mins);
    String secsString = _formatToString(secs);

    return '$minsString:$secsString';
  }

  String get positionTime => _msToTime(positionMillis);

  String get durationTime => _msToTime(durationMillis);

  void onPlay() async {
    if (audioPlayer != null) {
      await audioPlayer?.resume();
      setState(() {
        isPlaying = true;
      });
    }
  }

  void onPause() async {
    if (audioPlayer != null) {
      await audioPlayer?.pause();
      setState(() {
        isPlaying = false;
      });
    }
  }

  void onReplay() {
    final wantedMillis = max(positionMillis - 10000, 0);
    audioPlayer?.seek(Duration(milliseconds: wantedMillis));
  }

  void onForward() {
    final wantedMillis = min(positionMillis + 10000, durationMillis);
    audioPlayer?.seek(Duration(milliseconds: wantedMillis));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PredefinedColors.primary,
        title: const Text('Play'),
      ),
      body: Container(
        color: PredefinedColors.background,
        width: double.infinity,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: FavouriteButton(
                  isFavourited: isFavourited,
                  onPress: onFavourite,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 31),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(widget.meditation.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      widget.meditation.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.meditation.subtitle,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PlayerControls(
                      isPlaying: isPlaying,
                      onPlay: onPlay,
                      onPause: onPause,
                      onReplay: onReplay,
                      onForward: onForward,
                      positionTime: positionTime,
                      durationTime: durationTime,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
