import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const String _prefix = "meditation";
  static const String _favouritesKey = '$_prefix.favourites';
  static const String _activityKey = '$_prefix.activity';

  static DateTime _stringToDate(String formattedDate) {
    List<String> parts = formattedDate.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  static String _dateToString(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  static Future<List<String>?> _getList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  static void _updateList(String key, String item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> currentList = await _getList(key) ?? [];

    if (currentList.contains(item)) {
      currentList.remove(item);
    } else {
      currentList.add(item);
    }

    prefs.setStringList(key, currentList);
  }

  static Future<bool> _isInList(String key, String item) async {
    final List<String> list = await _getList(key) ?? [];
    return list.contains(item);
  }

  static Future<String> _getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static void _setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<List<String>> getFavourites() async {
    return await _getList(_favouritesKey) ?? [];
  }

  static void updateFavourites(String meditationId) async {
    _updateList(_favouritesKey, meditationId);
  }

  static Future<bool> isFavourite(String meditationId) async {
    return _isInList(_favouritesKey, meditationId);
  }

  static Future<Map<DateTime, List<int>>> getActivity() async {
    String? activityJson = await _getString(_activityKey) ?? "{}";
    Map<String, dynamic> activitiesMap = jsonDecode(activityJson);

    return activitiesMap.map(
      (key, values) => MapEntry(
        _stringToDate(key),
        values.cast<int>(),
      ),
    );
  }

  static Future<Map<DateTime, List<int>>> updateActivity(
      DateTime date, int duration) async {
    Map<DateTime, List<int>> activity = await getActivity();

    if (activity[date] == null) {
      activity[date] = [];
    }
    activity[date]?.add(duration);

    Map<String, List<int>> formattedActivity = activity.map(
      (key, value) => MapEntry(
        _dateToString(key),
        value,
      ),
    );

    String activityJson = jsonEncode(formattedActivity);

    _setString(_activityKey, activityJson);

    return activity;
  }

  static void clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
