import 'package:builders_group/firebase_options.dart';
import 'package:builders_group/src/app/app.dart';
import 'package:builders_group/src/settings/setting_controller.dart';
import 'package:builders_group/src/settings/setting_service.dart';
import 'package:builders_group/src/shared/services/firebase_messaging_service.dart';
import 'package:builders_group/src/shared/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationService.showCallNotification();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: defaultTargetPlatform == TargetPlatform.android ? 'Widgets' : null,
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  NotificationService.initialize();
  FirebaseMessagingService().initialize();
  runApp(MyApp(settingsController: settingsController));
}
