import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const String _prefix = "meditation";
  static const String _favouritesKey = '$_prefix.favourites';

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

  static Future<List<String>> getFavourites() async {
    return await _getList(_favouritesKey) ?? [];
  }

  static void updateFavourites(String meditationId) async {
    _updateList(_favouritesKey, meditationId);
  }

  static Future<bool> isFavourite(String meditationId) async {
    return _isInList(_favouritesKey, meditationId);
  }
}
