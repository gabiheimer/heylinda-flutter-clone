import 'package:app/screens/Settings/About.dart';
import 'package:app/storage/Storage.dart';
import 'package:app/styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  void clearData(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Clear Data",
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          height: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Are you sure you want to delete your data? All your stats will be reset. This cannot be undone.",
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Storage.clearData();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Clear Data",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: PredefinedColors.primary,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
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
              onTap: () => clearData(context),
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
