import 'package:builders_group/src/app/app_scaffold.dart';
import 'package:builders_group/src/app/features/login/login_view.dart';
import 'package:builders_group/src/app/features/forum/forum_view.dart';
import 'package:builders_group/src/app/features/notifications/notification_response_view.dart';
import 'package:builders_group/src/app/features/notifications/visitor_notification_view.dart';
import 'package:builders_group/src/shared/models/page_arguments.dart';
import 'package:builders_group/src/shared/widgets/language_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:builders_group/src/app/routes/app_route_name.dart';

class AppRoute {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.login:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => Login(),
          transitionDuration: const Duration(microseconds: 300),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      case AppRouteName.langSelection:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => LanguageSelectionScreen(),
          transitionDuration: const Duration(microseconds: 300),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );

      case AppRouteName.home:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const AppScaffold(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      case AppRouteName.forum:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const ForumView(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );

      case AppRouteName.visitorNotification:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const VisitorNotification(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      case AppRouteName.notificationReponse:
        PageArguments args = settings.arguments as PageArguments;
        bool isapproved = args.data!['isapproved'];
        return PageRouteBuilder(
          settings: settings,
          pageBuilder:
              (_, __, ___) => NotificationResponseView(isapproved: isapproved),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
    }

    return _errorRoute(settings.name);
  }

  static _errorRoute(name) {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error - 404')),
          body: const Center(child: Text('Error Not Found - 404')),
        );
      },
    );
  }
}
