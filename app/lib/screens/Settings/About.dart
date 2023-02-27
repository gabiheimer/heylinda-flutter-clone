import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../styles/Colors.dart';

class About extends StatefulWidget {
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  void openAboutUs() async {
    const url = 'https://www.heylinda.app/about';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  VisualDensity get tileVisualDensity => const VisualDensity(vertical: -4);

  String version = '-';
  String buildNumber = '-';

  @override
  Widget build(BuildContext context) {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      });
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PredefinedColors.primary,
        title: const Text('About'),
      ),
      body: Container(
        color: PredefinedColors.background,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ListTile(
                visualDensity: tileVisualDensity,
                title: const Text("Application Version"),
                trailing: Text(version),
              ),
            ),
            const Divider(),
            ListTile(
                visualDensity: tileVisualDensity,
                title: const Text("Build Version"),
                trailing: Text(buildNumber)),
            const Divider(),
            ListTile(
              visualDensity: tileVisualDensity,
              title: const Text("About Us"),
              onTap: openAboutUs,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
