import 'package:builders_group/src/l10n/app_localizations.dart';
import 'package:builders_group/src/theme/app_button_style.dart';
import 'package:builders_group/src/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AmenitiesView extends StatelessWidget {
  const AmenitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('amenities')),
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            itemBuilder: (_, index) {
              return _amenityCard(index, context);
            },
            itemCount: 4,
          ),
        ),
      ),
    );
  }

  _amenityCard(int index, BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(8.0),
      clipBehavior: Clip.hardEdge,
      child: Column(
        spacing: 8,
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://picsum.photos/500/200?random=${index + 2 * index + 1}',
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8,
              children: [
                Text(
                  '${AppLocalizations.of(context).translate('amenities')} ${index+1}',
                  style: AppTheme.titleStyle,
                ),
                Row(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on_outlined),
                    Text('Club House'),
                  ],
                ),
                Row(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.access_time_outlined),
                    Text('8:00AM to 8:00PM'),
                  ],
                ),

                ElevatedButton(
                  onPressed: () {},
                  style: AppButtonStyles.filled(context),
                  child: Text(AppLocalizations.of(context).translate('book_now')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
