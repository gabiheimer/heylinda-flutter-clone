import 'package:app/data/meditations.dart';
import 'package:flutter/material.dart';

import '../../styles/Colors.dart';
import '../../widgets/FavouriteButton.dart';
import 'PlayerControls.dart';

class Play extends StatelessWidget {
  const Play({super.key, required this.meditation});

  final Meditation meditation;

  // TODO: implement state
  bool get isFavourited => true;

  void onFavourite() {
    // TODO: implement function
  }

  // TODO: implement play audio functionality
  bool get isPlaying => true;
  String get positionTime => '00:00';
  String get durationTime => '02:15';

  void onPlay() {}
  void onPause() {}
  void onReplay() {}
  void onForward() {}

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
                          image: AssetImage(meditation.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      meditation.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      meditation.subtitle,
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
