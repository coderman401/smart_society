import 'package:builders_group/src/l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('services')),
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: GridView.builder(
          // shrinkWrap: true,
          // physics: ScrollPhysics(parent: ScrollPhysics()),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // number of items in each row
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
            childAspectRatio: 16 / 9,
          ),

          itemCount: 10,
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) {
            return _serviceCard(index, context);
          },
        ),
      ),
    );
  }

  _serviceCard(int index, BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(4.0),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://picsum.photos/400/200?random=${index + 2 * index + 1}',
            fit: BoxFit.fill,
            height: 200,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withValues(
                alpha: 0.67,
              ), // Dark overlay effect
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '${AppLocalizations.of(context).translate('services')} ${index+1}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
