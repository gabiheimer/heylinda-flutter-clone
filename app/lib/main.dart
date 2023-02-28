import 'package:app/navigation/MainTabNavigator.dart';
import 'package:app/styles/Colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // TODO: edit theme
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: PredefinedColors.primary,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: PredefinedColors.text),
        ),
      ),
      home: const MainTabNavigator(),
    );
  }
}
