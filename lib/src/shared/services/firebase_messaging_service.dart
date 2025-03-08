import 'package:builders_group/src/shared/services/shared_preferences_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'notification_service.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class FirebaseMessagingService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final SharedPreferencesService _preferencesService =
      SharedPreferencesService();

  void initialize() {
    Future<String?> token =
        defaultTargetPlatform == TargetPlatform.iOS
            ? _messaging.getAPNSToken()
            : _messaging.getToken();

    token.then((value) async {
      if (value != null) {
        await _preferencesService.setData('FCM_TOKEN', value);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // if (message.data['type'] == 'call') {
      NotificationService.showCallNotification();
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint("Call notification tapped");
    });
  }
}
