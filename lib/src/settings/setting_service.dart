// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:builders_group/src/shared/constants/app_constants.dart';
import 'package:builders_group/src/shared/models/user.model.dart';
import 'package:builders_group/src/shared/services/api_client_provider.dart';
import 'package:builders_group/src/shared/services/shared_preferences_service.dart';
import 'package:builders_group/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SettingsService {
  final SharedPreferencesService _preferencesService =
      SharedPreferencesService();

  Map<String, dynamic> currentUser = {};

  bool isFabVisible = true;
  final String JWT_TOKEN_KEY = 'JWT_TOKEN';
  final String CURRENT_USER_KEY = 'CURRENT_USER';
  final String THEME_KEY = 'DARK_THEME';

  Future<bool> themeMode() async =>
      await _preferencesService.getBool(THEME_KEY) ?? false;

  Future<String> getLocale() async =>
      await _preferencesService.getString('LOCALE');

  Future<ThemeData> themeData(Brightness? brightness) async {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppTheme.primary,
          secondary: AppTheme.secondary,
          primary: AppTheme.primary,
          brightness: brightness!,
        ),
        appBarTheme: AppBarTheme(centerTitle: false, titleSpacing: 0),
        useMaterial3: true,
        brightness: brightness,
        fontFamily: 'Montserrat');
  }

  Future<void> updateThemeMode(bool isDarkTheme) async {
    await _preferencesService.setData(THEME_KEY, isDarkTheme);
  }
  Future<void> setLocale(String locale) async {
    await _preferencesService.setData('LOCALE', locale);
  }

  Future<String> getJwtToken() async {
    return await _preferencesService.getString(JWT_TOKEN_KEY);
  }

  Future<void> updateJwtToken(String token) async {
    await _preferencesService.setData(JWT_TOKEN_KEY, token);
  }

  Future<User?> getCurrentUser(token) async {
    dynamic json = await _preferencesService.getData(CURRENT_USER_KEY);
    User? userModel = json != null ? User.fromJson(json) : null;

    if (userModel != null) {
      try {
        APIClient client = APIClient(http.Client(), null, jwtToken: token);
        dynamic response =
            await client.get(Uri.parse("${AppConstants.baseUrl}user/detail"));
        final dynamic body = jsonDecode(response.body);
        if (response.statusCode == 200) {
          final dynamic data = body['data'];
          return data;
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return userModel;
  }

  Future<void> updateCurrentUser(dynamic user) async {
    await _preferencesService.setData(CURRENT_USER_KEY, user);
  }

  Future<void> removeUserData() async {
    await _preferencesService.remove(JWT_TOKEN_KEY);
    await _preferencesService.remove(CURRENT_USER_KEY);
  }

}
