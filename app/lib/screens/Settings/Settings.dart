import 'package:app/screens/Settings/About.dart';
import 'package:app/styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  void clearData() {
    // TODO: implement clear data function
  }

  void openPrivacyPolicy() async {
    const url = 'https://www.heylinda.app/privacy';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  VisualDensity get tileVisualDensity => const VisualDensity(vertical: -4);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PredefinedColors.background,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListTile(
              visualDensity: tileVisualDensity,
              title: const Text("Clear Data"),
              onTap: clearData,
            ),
          ),
          const Divider(),
          ListTile(
            visualDensity: tileVisualDensity,
            title: const Text("Privacy Policy"),
            onTap: openPrivacyPolicy,
          ),
          const Divider(),
          ListTile(
            visualDensity: tileVisualDensity,
            title: const Text("About"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => About(),
                ),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
