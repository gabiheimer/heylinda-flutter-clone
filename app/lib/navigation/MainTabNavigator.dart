import 'package:app/screens/Home/Home.dart';
import 'package:app/screens/Settings/Settings.dart';
import 'package:app/screens/Stats/Stats.dart';
import 'package:app/styles/Colors.dart';
import 'package:flutter/material.dart';

class Route {
  Widget screen;
  String name;

  Route({required this.name, required this.screen});
}

final List<Route> routes = [
  Route(
    name: 'Home',
    screen: const Home(),
  ),
  Route(
    name: 'Stats',
    screen: const Stats(),
  ),
  Route(
    name: 'Settings',
    screen: const Settings(),
  ),
];

class MainTabNavigator extends StatefulWidget {
  const MainTabNavigator({super.key});

  @override
  State<MainTabNavigator> createState() => _MainTabNavigatorState();
}

class _MainTabNavigatorState extends State<MainTabNavigator> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String title = routes[_selectedIndex].name;
    final Widget screen = routes[_selectedIndex].screen;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PredefinedColors.primary,
        title: Text(title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
        selectedItemColor: PredefinedColors.primary,
        selectedFontSize: 12,
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
      body: Container(
        color: PredefinedColors.background,
        child: screen,
      ),
    );
  }
}
