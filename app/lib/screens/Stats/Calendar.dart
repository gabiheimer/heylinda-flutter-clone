import 'dart:core';

import 'package:app/styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar({
    super.key,
    required this.getCalendarData,
    required this.markedDates,
  });

  final Future<void> Function() getCalendarData;
  final Set<DateTime> markedDates;

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
        selectedDayPredicate: (day) {
          final formattedDay = DateTime(day.year, day.month, day.day);
          return markedDates.contains(formattedDay);
        },
      ),
    );
  }
}
