import 'package:builders_group/src/app/routes/app_route_name.dart';
import 'package:builders_group/src/l10n/app_localizations.dart';
import 'package:builders_group/src/shared/models/page_arguments.dart';
import 'package:builders_group/src/theme/app_button_style.dart';
import 'package:builders_group/src/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VisitorNotification extends StatelessWidget {
  const VisitorNotification({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorscheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorscheme.primary,
        foregroundColor: colorscheme.onPrimary,
        titleSpacing: 16,
        title: Text(AppLocalizations.of(context).translate('visitor_notification')),
      ),
      body: Card(
        elevation: 0,
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16,
            children: [
              Text(
                'LOGO',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.grey,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 48),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: colorscheme.primary, width: 4),
                ),
                width: 150,
                height: 150,
                child: Image.asset(
                  'assets/images/visitor.png',
                  fit: BoxFit.fill,
                ),
              ),
              Text('${AppLocalizations.of(context).translate('delivery')} - Zomato', style: AppTheme.titleStyle),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colorscheme.primary, width: 1),
                ),
                clipBehavior: Clip.hardEdge,
                padding: EdgeInsets.all(16),
                child: Row(
                  spacing: 16,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://play-lh.googleusercontent.com/HJdzprqlCwh_8YNyhMBU6rIaGBGwxHXflZuuqI3iR4US7Jb-bSYiJk_DKV2la9SoBM0K=w480-h960-rw',
                      width: 60,
                      height: 60,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context).translate('name'), style: AppTheme.subTitleStyle),
                          Text(
                            '+91 9876543210',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.call, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).popAndPushNamed(
                              AppRouteName.notificationReponse,
                              arguments: PageArguments(
                                data: {'isapproved': true},
                              ),
                            );
                          },
                          style: AppButtonStyles.filled(context).copyWith(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.green.shade700,
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context).translate('approve'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              AppRouteName.notificationReponse,
                              arguments: PageArguments(
                                data: {'isapproved': false},
                              ),
                            );
                          },
                          style: AppButtonStyles.filled(context).copyWith(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.red.shade700,
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context).translate('deny'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              AppRouteName.notificationReponse,
                              arguments: PageArguments(
                                data: {'isapproved': true},
                              ),
                            );
                          },
                          style: AppButtonStyles.filled(context).copyWith(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.grey.shade600,
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(
                              context,
                            ).translate('collect_parcel'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
