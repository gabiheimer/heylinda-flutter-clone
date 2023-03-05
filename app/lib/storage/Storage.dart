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

  static Future<Map<DateTime, int>> getActivity() async {
    String? activityJson = await _getString(_activityKey) ?? "{}";
    Map<String, dynamic> activitiesMap = jsonDecode(activityJson);

    return activitiesMap.map(
      (key, value) => MapEntry(
        _stringToDate(key),
        int.parse(value),
      ),
    );
  }

  static Future<Map<DateTime, int>> updateActivity(
      DateTime date, int duration) async {
    Map<DateTime, int> activity = await getActivity();

    if (duration == 0 && activity.containsKey(date)) {
      activity.remove(date);
    } else if (duration > 0) {
      activity[date] = duration;
    }

    Map<String, String> formattedActivity = activity.map(
      (key, value) => MapEntry(
        _dateToString(key),
        value.toString(),
      ),
    );

    String activityJson = jsonEncode(formattedActivity);
    _setString(_activityKey, activityJson);

    return activity;
  }
}
