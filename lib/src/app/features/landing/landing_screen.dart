import 'package:builders_group/src/l10n/app_localizations.dart';
import 'package:builders_group/src/shared/widgets/app_carousel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: AppCarousel(
              items: [
                'https://picsum.photos/1200/500?random=11',
                'https://picsum.photos/1200/500?random=22',
                'https://picsum.photos/1200/500?random=33',
                'https://picsum.photos/1200/500?random=44',
                'https://picsum.photos/1200/500?random=55',
              ],
              indicatorAlignment: IndicatorAlignment.CENTER,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(
                      context,
                    ).translate('popular_properties'),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppLocalizations.of(context).translate('view_all'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (conext, index) {
                return Card(
                  elevation: 8,
                  margin: const EdgeInsets.all(16),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            'https://picsum.photos/600/400?random=1$index',
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) {
                          return Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          );
                        },
                        height: 160,
                        width: 300,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(
                                context,
                              ).translate('sample_propery'),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              index > 2
                                  ? AppLocalizations.of(
                                    context,
                                  ).translate('sold_out')
                                  : index > 0
                                  ? AppLocalizations.of(
                                    context,
                                  ).translate('ready_to_move')
                                  : AppLocalizations.of(
                                    context,
                                  ).translate('available'),
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: 300 - 16,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                spacing: 16,
                                children: [
                                  Row(
                                    spacing: 8,
                                    children: [
                                      Icon(Icons.bed_rounded),
                                      Text(
                                        "2 & 3 BHK",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      spacing: 8,
                                      children: [
                                        Icon(Icons.sim_card_download_outlined),
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          ).translate('brochure'),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: 8,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Card(
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            clipBehavior: Clip.hardEdge,
            elevation: 8,
            child: CachedNetworkImage(
              imageUrl: 'https://picsum.photos/1200/500?random=1',
              progressIndicatorBuilder: (context, url, progress) {
                return Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                );
              },
              // fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 120),
        ],
      ),
    );
  }
}
