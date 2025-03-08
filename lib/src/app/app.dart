import 'package:builders_group/src/app/routes/app_route.dart';
import 'package:builders_group/src/app/routes/app_route_name.dart';
import 'package:builders_group/src/settings/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:builders_group/src/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    String initialRoute = AppRouteName.home;
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => settingsController)],
      child: Consumer<SettingsController>(
        builder: (context, value, child) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: MaterialApp(
              title: 'Builder\'s Group',
              theme: settingsController.themeData,
              restorationScopeId: 'app',
              initialRoute: initialRoute,
              
              onGenerateRoute: AppRoute.generate,
              locale: settingsController.locale,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en', ''), // English
                const Locale('hi', ''), // Hindi
                const  Locale('gu', ''), // Gujarati
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
            ),
          );
        },
      ),
    );
  }
}
