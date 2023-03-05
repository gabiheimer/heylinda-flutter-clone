import 'dart:core';

import 'package:app/screens/Stats/ManualEntry.dart';
import 'package:app/styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar({
    super.key,
    required this.getCalendarData,
    required this.markedDates,
    required this.activity,
  });

  final Future<void> Function() getCalendarData;
  final Set<DateTime> markedDates;
  final Map<DateTime, int> activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 14, bottom: 30),
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        currentDay: DateTime.now(),
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(
            color: PredefinedColors.primary,
            fontWeight: FontWeight.bold,
          ),
          defaultTextStyle: TextStyle(
            color: PredefinedColors.gray900,
          ),
          selectedDecoration: BoxDecoration(
            color: PredefinedColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: PredefinedColors.gray900,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: PredefinedColors.gray900,
          ),
        ),
        onDaySelected: (selectedDay, focusedDay) async {
          if (selectedDay.millisecondsSinceEpoch >
              DateTime.now().millisecondsSinceEpoch) return;

          final formattedSelectedDay = DateTime(
            selectedDay.year,
            selectedDay.month,
            selectedDay.day,
          );

          return await showDialog(
            context: context,
            builder: (context) => ManualEntry(
              selectedDay: formattedSelectedDay,
              getCalendarData: getCalendarData,
              activity: activity,
            ),
          );
        },
        selectedDayPredicate: (day) {
          final formattedDay = DateTime(day.year, day.month, day.day);
          return markedDates.contains(formattedDay);
        },
      ),
    );
  }
}
