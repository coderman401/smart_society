// filepath: /Users/kavyahalani/Development/builders_group/lib/src/widgets/language_selector.dart
import 'package:builders_group/src/app/routes/app_route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:builders_group/src/settings/setting_controller.dart';

class LanguageSelector extends StatelessWidget {
  final bool dropdown;
  const LanguageSelector({super.key, required this.dropdown});

  @override
  Widget build(BuildContext context) {
    return dropdown
        ? DropdownButton<Locale>(
          value: Provider.of<SettingsController>(context).locale,
          onChanged: (Locale? newLocale) {
            if (newLocale != null) {
              Provider.of<SettingsController>(
                context,
                listen: false,
              ).updateLocale(newLocale);
            }
          },
          items: [
            DropdownMenuItem(value: Locale('en', ''), child: Text('English')),
            DropdownMenuItem(value: Locale('hi', ''), child: Text('हिन्दी')),
            DropdownMenuItem(value: Locale('gu', ''), child: Text('ગુજરાતી')),
          ],
        )
        : IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRouteName.langSelection
              // (route) => false,
            );
          },
          icon: Icon((Icons.translate_rounded)),
        );
  }
}
