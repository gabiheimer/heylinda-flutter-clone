import 'package:app/screens/Stats/Calendar.dart';
import 'package:app/styles/Colors.dart';
import 'package:app/templates/ScreenTemplate.dart';
import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  const Stats({super.key});

  // TODO: get data from storage
  get streak => 1;
  get totalSessions => 1;
  get listenedStat => "0 minutes";

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      title: "Stats",
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 36, bottom: 36, left: 14),
        child: Column(
          children: [
            SizedBox(
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  _DataCard(
                    icon: Icons.emoji_events_outlined,
                    dataLabel: 'Current Streak',
                    dataValue: '$streak day${streak == 1 ? '' : 's'}',
                  ),
                  _DataCard(
                    icon: Icons.calendar_month,
                    dataLabel: 'Total Sessions',
                    dataValue:
                        '$totalSessions session${totalSessions == 1 ? '' : 's'}',
                  ),
                  _DataCard(
                    icon: Icons.access_time,
                    dataLabel: 'Time Meditating',
                    dataValue: listenedStat,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Calendar()
          ],
        ),
      ),
    );
  }
}

class _DataCard extends StatelessWidget {
  const _DataCard({
    Key? key,
    required this.icon,
    required this.dataLabel,
    required this.dataValue,
  }) : super(key: key);

  final IconData icon;
  final String dataLabel;
  final String dataValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        margin: const EdgeInsets.only(right: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 33,
                color: PredefinedColors.primary,
              ),
              const SizedBox(height: 8),
              Text(
                dataLabel,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                dataValue,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
