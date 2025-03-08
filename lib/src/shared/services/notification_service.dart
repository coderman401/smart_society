import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
  debugPrint('notificationTapBackground');
  debugPrint(notificationResponse.payload);
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    final InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: initializationSettingsDarwin,
    );

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final bool? result = await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      debugPrint(result.toString());
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      final bool? result =
          await _notificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()!
              .requestNotificationsPermission();
      debugPrint(result.toString());
    }

    _notificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: (details) {
        // Handle tapping on notification
        debugPrint("Notification clicked");
      },
    );
  }

  static void showCallNotification() async {
    debugPrint('calling.......');
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'call_channel_id',
          'Visitor Channel',
          channelDescription: 'Show when there is a visitor',
          actions: [
            AndroidNotificationAction(
              'accept',
              "Accept",
              titleColor: Colors.green,
              showsUserInterface: true,
            ),
            AndroidNotificationAction(
              'reject',
              "Reject",
              titleColor: Colors.red,
              showsUserInterface: true,
            ),
          ],
          color: Colors.teal,
          playSound: true,
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: true,
          category: AndroidNotificationCategory.call,
        );
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          interruptionLevel: InterruptionLevel.timeSensitive,
          categoryIdentifier: 'ACTION_CATEGORY',
          badgeNumber: 0,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _notificationsPlugin.show(
      0,
      'Visitor',
      'You have visitor at gate please approve.',
      platformChannelSpecifics,
      payload: 'call_data',
    );
  }
}
