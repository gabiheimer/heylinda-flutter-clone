import 'package:flutter/material.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton(
      {super.key, required this.download, required this.isInitiallyDownloaded});

  final Future<void> Function() download;
  final Future<bool> Function() isInitiallyDownloaded;

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool downloaded = false;
  bool downloading = false;

  void initDownloaded() async {
    bool initiallyDownloaded = await widget.isInitiallyDownloaded();
    setState(() {
      downloaded = initiallyDownloaded;
    });
  }

  @override
  void initState() {
    initDownloaded();
    super.initState();
  }

  void onDownload() async {
    if (downloaded) return;

    setState(() {
      downloaded = false;
      downloading = true;
    });

    await widget.download();

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
          onPressed: onDownload,
        ),
      );
    }
  }
}
