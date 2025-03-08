import 'package:builders_group/src/l10n/app_localizations.dart';
import 'package:builders_group/src/settings/setting_controller.dart';
import 'package:builders_group/src/theme/app_button_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  late Locale selectedLocale;
  late Locale currentLocale;

  @override
  void initState() {
    super.initState();
    currentLocale =
        Provider.of<SettingsController>(context, listen: false).locale;
    selectedLocale = currentLocale;
  }

  @override
  Widget build(BuildContext context) {
    SettingsController controller = Provider.of<SettingsController>(
      context,
      listen: false,
    );

    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 20,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(Icons.language, size: 50, color: Colors.deepPurple),
              ),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('welcome'),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  Text(
                    AppLocalizations.of(context).translate('select_lang'),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Expanded(
                child: Column(
                  spacing: 24,
                  children: [
                    _buildLanguageOption(
                      "English",
                      "English",
                      "🇺🇸",
                      Locale('en'),
                    ),
                    _buildLanguageOption(
                      "Hindi",
                      "हिन्दी",
                      "🇮🇳",
                      Locale('hi'),
                    ),
                    _buildLanguageOption(
                      "Gujarati",
                      "ગુજરાતી",
                      "🇮🇳",
                      Locale('gu'),
                    ),
                  ],
                ),
              ),

              // Language Selection Buttons
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (selectedLocale != controller.locale) {
                          controller.updateLocale(selectedLocale);
                        }
                      },
                      style: AppButtonStyles.filled(context),
                      child: Text(AppLocalizations.of(context).translate('save')),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Language Tile with Animated Button
  Widget _buildLanguageOption(
    String language,
    String label,
    String flag,
    Locale locale,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLocale = locale;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color:
                selectedLocale.languageCode == locale.languageCode
                    ? Colors.green
                    : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Row(
          spacing: 32,
          children: [
            Text(flag, style: const TextStyle(fontSize: 48)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(language),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (selectedLocale.languageCode == locale.languageCode)
              Icon(Icons.check_circle_outline_rounded, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
