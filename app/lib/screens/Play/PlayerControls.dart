import 'package:app/styles/Colors.dart';
import 'package:flutter/material.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({
    super.key,
    required this.positionTime,
    required this.durationTime,
    required this.isPlaying,
    required this.onPause,
    required this.onPlay,
    required this.onReplay,
    required this.onForward,
  });

  final String positionTime;
  final String durationTime;
  final bool isPlaying;
  final void Function() onPause;
  final void Function() onPlay;
  final void Function() onReplay;
  final void Function() onForward;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(positionTime),
        _PlayerIcon(icon: Icons.replay_10, onPressed: onReplay, size: 30),
        isPlaying
            ? _PlayerIcon(
                icon: Icons.pause_circle_filled,
                onPressed: onPause,
              )
            : _PlayerIcon(
                icon: Icons.play_circle_filled,
                onPressed: onPlay,
              ),
        _PlayerIcon(
          icon: Icons.forward_10,
          onPressed: onForward,
          size: 30,
        ),
        Text(durationTime),
      ],
    );
  }
}

class _PlayerIcon extends StatelessWidget {
  const _PlayerIcon({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size,
  });

  final IconData icon;
  final double? size;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        icon,
        size: size ?? 50,
        color: PredefinedColors.primary,
      ),
    );
  }
}
