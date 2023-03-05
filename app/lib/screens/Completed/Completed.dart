import 'package:app/styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Completed extends StatelessWidget {
  const Completed({super.key, required this.totalSessions});

  final int totalSessions;

  void onPressDonate() async {
    const url = 'https://opencollective.com/heylinda/donate';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void onPressSkip(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        color: PredefinedColors.primary,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              size: 50,
              color: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Congratulations!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'You have completed $totalSessions meditation${totalSessions == 1 ? '' : 's'}!\nDo you want to give a donation?',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18, color: Colors.white, height: 1.5),
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: onPressDonate,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'DONATE',
                  style: TextStyle(
                      color: PredefinedColors.primary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () => onPressSkip(context),
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                color: Colors.white,
              )),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'SKIP',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
