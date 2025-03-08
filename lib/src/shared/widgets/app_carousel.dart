// ignore_for_file: constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

enum IndicatorAlignment { LEFT, RIGHT, CENTER }

class AppCarousel extends StatefulWidget {
  final List<String> items;
  final IndicatorAlignment indicatorAlignment;
  final double? width;
  const AppCarousel({
    super.key,
    required this.items,
    this.indicatorAlignment = IndicatorAlignment.CENTER,
    this.width,
  });

  @override
  State<AppCarousel> createState() => _AppCarouselState();
}

class _AppCarouselState extends State<AppCarousel> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double width = widget.width ?? size.width;

    return Stack(
      children: [
        CarouselSlider(
          carouselController: _controller,
          items:
              widget.items.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: width * (9 / 16),
                      width: width,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: CachedNetworkImage(
                          imageUrl: i,
                          progressIndicatorBuilder: (context, url, progress) {
                            return Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                              ),
                            );
                          },
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: widget.items.length > 1,
            pageSnapping: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 300),
            autoPlayAnimationDuration: Duration(milliseconds: 8000000),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        _buildCarouselIndicator(size),
      ],
    );
  }

  _buildCarouselIndicator(size) {
    return Positioned(
      bottom: 8,
      child: Container(
        width: size.width - 32,
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment:
              IndicatorAlignment.LEFT == widget.indicatorAlignment
                  ? MainAxisAlignment.start
                  : IndicatorAlignment.RIGHT == widget.indicatorAlignment
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            ...widget.items.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _current == entry.key
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.4),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
