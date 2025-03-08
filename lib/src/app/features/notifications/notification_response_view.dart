import 'package:builders_group/src/app/routes/app_route_name.dart';
import 'package:builders_group/src/l10n/app_localizations.dart';
import 'package:builders_group/src/theme/theme.dart';
import 'package:flutter/material.dart';

class NotificationResponseView extends StatelessWidget {
  final bool? isapproved;

  const NotificationResponseView({super.key, this.isapproved});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: Text(AppLocalizations.of(context).translate('visitor_notification')), leading: Container(),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(AppRouteName.home, (route) => false);
            },
          ),
        ],
        ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            children: [
              Card(
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:
                        isapproved == true
                            ? Colors.green.shade600.withValues(alpha: 0.7)
                            : Colors.red.shade500.withValues(alpha: 0.7),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    spacing: 16,
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: colorScheme.primary,
                            width: 4,
                          ),
                        ),
                        width: 60,
                        height: 60,
                        child: Image.asset(
                          'assets/images/visitor.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isapproved == true
                                  ? AppLocalizations.of(context).translate('entry_approved')
                                  : AppLocalizations.of(context).translate('entry_approved'),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context).translate('for_delivery', args:['Zomato']),
                              style: TextStyle(color: colorScheme.onPrimary),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.check_circle_outline_rounded, size: 32, color: colorScheme.onPrimary,),
                      SizedBox(width: 16)
                    ],
                  ),
                ),
              ),
              Expanded(child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: colorScheme.surface,
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 93, 181, 254).withValues(alpha: 0.8),
                      const Color.fromARGB(255, 92, 178, 218).withValues(alpha: 0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(AppLocalizations.of(context).translate('advertisement'), style: AppTheme.titleStyle.copyWith(color: Colors.blue.shade900),),
                ),

              ))
            ],
          ),
        ),
      ),
    );
  }
}
