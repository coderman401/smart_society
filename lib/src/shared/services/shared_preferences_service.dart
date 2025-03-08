import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService._internal();

  factory SharedPreferencesService() {
    return _sharedPreferencesService;
  }

  SharedPreferencesService._internal();

  Future<dynamic> getData(String key) async {
    final sharedPref = await SharedPreferences.getInstance();
    final data = sharedPref.get(key);
    if (data != null) {
      return jsonDecode(data.toString());
    }
    return data;
  }

  Future<bool> pushItem(String key, dynamic data) async {
    dynamic list = await getData(key);
    if (list != null) {
      list.add(data);
      list = jsonEncode(list);
      return setData(key, list);
    }
    return Future.value(true);
  }

  Future<bool> updateItem(String key, dynamic data, String refId) async {
    dynamic list = await getData(key);
    if (list != null) {
      for (var element in list) {
        if (element['uniqueId'] == refId) {
          element.forEach((key, value) {
            element[key.toString()] = data[key.toString()];
          });
        }
      }
      list = jsonEncode(list);
      return setData(key, list);
    }
    return Future.value(true);
  }

  Future<bool> removeItem(String key, String refId) async {
    dynamic list = await getData(key);
    if (list != null) {
      int index = list.indexWhere((element) => element['uniqueId'] == refId);
      if (index >= 0) {
        list.removeAt(index);
      }
      list = jsonEncode(list);
      return setData(key, list);
    }
    return Future.value(true);
  }

  Future<bool?> getBool(String key) async {
    final sharedPref = await SharedPreferences.getInstance();
    final data = sharedPref.getBool(key);
    return data;
  }

  Future<String> getString(String key) async {
    final sharedPref = await SharedPreferences.getInstance();
    final data = sharedPref.getString(key);
    return data ?? '';
  }

  Future<bool> setData(String key, dynamic value) async {
    final sharedPref = await SharedPreferences.getInstance();
    if (value is int) {
      return sharedPref.setInt(key, value);
    } else if (value is double) {
      return sharedPref.setDouble(key, value);
    } else if (value is String) {
      return sharedPref.setString(key, value);
    } else if (value is bool) {
      return sharedPref.setBool(key, value);
    } else {
      return sharedPref.setString(key, value);
    }
  }

  Future<bool> remove(String key) async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.remove(key);
  }

  Future<dynamic> removeAll() async {
    final sharedPref = await SharedPreferences.getInstance();
    final keys = sharedPref.getKeys();
    if (keys.isNotEmpty) {
      for (var key in keys) {
        sharedPref.remove(key);
      }
    }
  }

  Future<bool> increaseAlertCount() async {
    final sharedPref = await SharedPreferences.getInstance();
    int count = sharedPref.getInt("BUDGET_ALERT_COUNT") ?? 0;
    count += 1;
    return sharedPref.setInt("BUDGET_ALERT_COUNT", count);
  }

  Future<bool> resetAlertCount() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.setInt("BUDGET_ALERT_COUNT", 0);
  }

  Future<int> getAlertCount() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getInt("BUDGET_ALERT_COUNT") ?? 0;
  }
}
