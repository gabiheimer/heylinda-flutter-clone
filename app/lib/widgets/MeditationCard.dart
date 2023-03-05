import 'dart:io';

import 'package:app/data/meditations.dart';
import 'package:app/screens/Play/Play.dart';
import 'package:app/styles/Colors.dart';
import 'package:app/widgets/DownloadButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MeditationCard extends StatelessWidget {
  final Meditation item;
  final bool isPopular;
  final void Function(Meditation) updateFavourites;

  const MeditationCard({
    super.key,
    required this.item,
    this.isPopular = false,
    required this.updateFavourites,
  });

  void onTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Play(
          meditation: item,
          updateFavourites: updateFavourites,
        ),
      ),
    );
  }

  Future<String> getFilePath(String meditationUri) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filename = meditationUri.split('/').removeLast();
    return '${directory.path}/$filename';
  }

  Future<bool> isMeditationDownloaded() async {
    final String filePath = await getFilePath(item.uri);
    return File(filePath).exists();
  }

  Future<void> saveMeditationAudio() async {
    final String filePath = await getFilePath(item.uri);

    final HttpClient httpClient = HttpClient();
    final Uri uri = Uri.parse(item.uri);
    final HttpClientRequest request = await httpClient.getUrl(uri);
    final HttpClientResponse response = await request.close();
    final List<int> bytes = await consolidateHttpClientResponseBytes(response);

    // Save the file to disk
    final File file = File(filePath);
    await file.writeAsBytes(bytes);
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyText1?.color;
    final double imageHeight = isPopular ? 250 : 135;
    const double cardWidth = 250;

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () => onTap(context),
        child: Card(
          elevation: 1,
          child: InkWell(
            // TODO: add navigation onTap
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: cardWidth,
                  height: imageHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.subtitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${item.time} minutes",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: PredefinedColors.purple900,
                            ),
                          ),
                          DownloadButton(
                            download: saveMeditationAudio,
                            isInitiallyDownloaded: isMeditationDownloaded,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
