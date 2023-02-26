import 'package:app/styles/Colors.dart';
import 'package:flutter/material.dart';

class ManualEntry extends StatelessWidget {
  const ManualEntry({super.key});

// TODO: implement funcionality
  get defaultValue => "";
  get duration => 10;

  void onChangeText(String value) {
    // TODO: implement function
  }

  void onSubmit() {
    if (duration < 0) return;
    // TODO: implement function
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
          const Text('Enter how long you meditated for'),
          TextFormField(
            initialValue: defaultValue,
            keyboardType: TextInputType.number,
            maxLength: 3,
            onChanged: onChangeText,
            cursorColor: PredefinedColors.primary,
            decoration: InputDecoration(
              focusedBorder: borderStyle,
              enabledBorder: borderStyle,
            ),
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
          onPressed: onSubmit,
          child: const Text(
            'SUBMIT',
            style: TextStyle(color: PredefinedColors.primary),
          ),
        ),
      ],
    );
  }
}
