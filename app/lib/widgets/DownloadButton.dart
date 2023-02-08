import 'package:flutter/material.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton({super.key});

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool downloaded = false;
  bool downloading = false;

  void saveAudioFile() async {
    // TODO: add save audio file functionality

    setState(() {
      downloaded = false;
      downloading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      downloaded = true;
      downloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    const double buttonSize = 15;

    if (downloading) {
      return SizedBox(
        height: buttonSize,
        width: buttonSize,
        child: CircularProgressIndicator(
          color: primary,
          strokeWidth: 2,
        ),
      );
    } else if (downloaded) {
      return Icon(
        Icons.check_circle_outline,
        size: buttonSize,
        color: primary,
      );
    } else {
      return SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: IconButton(
          padding: const EdgeInsets.all(1),
          splashRadius: 10,
          iconSize: buttonSize,
          icon: Icon(
            Icons.download_outlined,
            size: buttonSize,
            color: primary,
          ),
          onPressed: saveAudioFile,
        ),
      );
    }
  }
}
