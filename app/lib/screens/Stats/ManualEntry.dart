import 'package:app/storage/Storage.dart';
import 'package:app/styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const MS_PER_MINUTE = 60000;

class ManualEntry extends StatefulWidget {
  const ManualEntry({
    super.key,
    required this.getCalendarData,
    required this.selectedDay,
    required this.activity,
  });

  final Future<void> Function() getCalendarData;
  final DateTime selectedDay;
  final Map<DateTime, int> activity;

  @override
  State<ManualEntry> createState() => _ManualEntryState();
}

class _ManualEntryState extends State<ManualEntry> {
  int duration = 0;
  String displayValue = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      final activity = widget.activity;
      final selectedDay = widget.selectedDay;
      duration = activity[selectedDay] ?? 0;
      displayValue =
          duration > 0 ? (duration / MS_PER_MINUTE).floor().toString() : "";
    });
  }

  void onChangeText(String value) {
    setState(() {
      duration = value != "" ? int.parse(value) * MS_PER_MINUTE : 0;
      displayValue = duration.toString();
    });
  }

  void onSubmit() async {
    if (duration < 0) return;

    await Storage.updateActivity(widget.selectedDay, duration);
    widget.getCalendarData();
  }

  void onDismiss(BuildContext context) {
    Navigator.of(context).pop();
  }

  InputBorder get borderStyle => const UnderlineInputBorder(
        borderSide: BorderSide(
          color: PredefinedColors.primary,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Manual Entry'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Enter how long you meditated for in minutes'),
          TextFormField(
            initialValue: displayValue,
            keyboardType: TextInputType.number,
            maxLength: 3,
            onChanged: onChangeText,
            cursorColor: PredefinedColors.primary,
            decoration: InputDecoration(
              focusedBorder: borderStyle,
              enabledBorder: borderStyle,
            ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => onDismiss(context),
          child: const Text(
            'CANCEL',
            style: TextStyle(color: PredefinedColors.gray900),
          ),
        ),
        TextButton(
          onPressed: () {
            onSubmit();
            onDismiss(context);
          },
          child: const Text(
            'SUBMIT',
            style: TextStyle(color: PredefinedColors.primary),
          ),
        ),
      ],
    );
  }
}
