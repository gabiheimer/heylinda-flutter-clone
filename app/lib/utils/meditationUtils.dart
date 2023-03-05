import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../data/meditations.dart';

Future<String> getMeditationFilePath(String meditationUri) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filename = meditationUri.split('/').removeLast();
  return '${directory.path}/$filename';
}
