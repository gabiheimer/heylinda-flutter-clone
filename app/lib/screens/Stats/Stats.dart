import 'dart:math';

import 'package:app/screens/Stats/Calendar.dart';
import 'package:app/storage/Storage.dart';
import 'package:app/styles/Colors.dart';
import 'package:flutter/material.dart';

import '../../data/quotes.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  Set<DateTime> markedDates = {};
  Map<DateTime, int> activity = {};
  int streak = 0;
  int totalSessions = 0;

  int getStreak() {
    DateTime now = DateTime.now();
    DateTime curDate = DateTime(now.year, now.month, now.day);
    int curStreak = 0;

    while (activity.containsKey(curDate)) {
      curStreak++;
      curDate = curDate.subtract(const Duration(days: 1));
    }

    return curStreak;
  }

  Future<void> getCalendarData() async {
    Map<DateTime, int> storedActivity = await Storage.getActivity();
    setState(() {
      activity = storedActivity;
      markedDates = activity.keys.toSet();
      streak = getStreak();
      totalSessions = activity.length;
    });
  }

  @override
  void initState() {
    getCalendarData();
    super.initState();
  }

  get listenedStat => "0 minutes";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          Calendar(
            getCalendarData: getCalendarData,
            markedDates: markedDates,
            activity: activity,
          ),
          const _QuoteCard(),
        ],
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

class _QuoteCard extends StatelessWidget {
  const _QuoteCard({
    super.key,
  });

  Quote get getQuote {
    final quotes = QuoteRepository.quotes;

    final int max = quotes.length - 1;
    final int r = Random().nextInt(max);

    return quotes[r];
  }

  @override
  Widget build(BuildContext context) {
    final quote = getQuote;

    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 30),
      child: Card(
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                quote.author,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                quote.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
