import 'dart:convert';

import 'package:builders_group/src/settings/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class APIClient {
  final http.Client _client;
  final BuildContext? _context;
  final String? jwtToken;

  APIClient(this._client, this._context, {this.jwtToken});

  // Function to get the JWT token from the AuthProvider
  String _getJwtToken() {
    return Provider.of<SettingsController>(_context!, listen: false).jwtToken;
  }

  // Send GET request with the JWT token
  Future<http.Response> get(Uri url) async {
    final token = jwtToken ?? _getJwtToken();
    final headers = {
      'Authorization': token.isNotEmpty ? 'Bearer $token' : '',
      'Content-Type': 'builders_group/json',
    };

    return await _client.get(url, headers: headers);
  }

  // Send POST request with the JWT token
  Future<http.Response> post(Uri url, {dynamic body}) async {
    final token = jwtToken ?? _getJwtToken();
    final headers = {
      'Authorization': token.isNotEmpty ? 'Bearer $token' : '',
      'Content-Type': 'builders_group/json',
    };

    return await _client.post(url,
        headers: headers, body: body != null ? jsonEncode(body) : null);
  }

  // You can add other methods (PUT, DELETE) as needed
}
