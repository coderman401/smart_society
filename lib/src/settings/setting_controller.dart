import 'dart:convert';

import 'package:builders_group/src/settings/setting_service.dart';
import 'package:builders_group/src/shared/models/user.model.dart';
import 'package:flutter/material.dart';

class SettingsController with ChangeNotifier {
  final SettingsService _settingsService;

  SettingsController(this._settingsService);

  late ThemeData _themeData;
  ThemeData get themeData => _themeData;

  late bool _isDarkTheme;
  bool get isDarkTheme => _isDarkTheme;

  late String _jwtToken;
  String get jwtToken => _jwtToken;

  User? _currentUser;
  User? get currentUser => _currentUser;

  late Locale _locale;
  Locale get locale => _locale;

  Future<void> loadSettings() async {
    _isDarkTheme = await _settingsService.themeMode();
    String languageCode = await _settingsService.getLocale();
    Brightness brightness = _isDarkTheme ? Brightness.dark : Brightness.light;
    _themeData = await _settingsService.themeData(brightness);
    _locale = Locale(languageCode.isEmpty ? 'en' : languageCode);
    _jwtToken = await _settingsService.getJwtToken();
    _currentUser = await _settingsService.getCurrentUser(_jwtToken);
    notifyListeners();
  }

  set currentUser(User? user) {
    _currentUser = user;
    if (user != null) {
      _settingsService.updateCurrentUser(jsonEncode(user.toJson()));
    }
    notifyListeners();
  }

  set jwtToken(value) {
    _jwtToken = value;
    _settingsService.updateJwtToken(_jwtToken);
    notifyListeners();
  }

  Future<void> logout() async {
    await _settingsService.removeUserData();
    _currentUser = null;
    _jwtToken = '';
    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  Future<void> updateThemeData(bool? isDarkTheme) async {
    if (isDarkTheme == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (isDarkTheme == _isDarkTheme) return;

    _isDarkTheme = isDarkTheme;
    await _settingsService.updateThemeMode(_isDarkTheme);

    Brightness brightness = _isDarkTheme ? Brightness.dark : Brightness.light;

    _themeData = await _settingsService.themeData(brightness);

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  void updateTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  void updateLocale(Locale locale) async {
    _locale = locale;
    await _settingsService.setLocale(locale.languageCode);
    notifyListeners();
  }
}
