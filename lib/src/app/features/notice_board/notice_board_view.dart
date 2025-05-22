import 'dart:math';

import 'package:builders_group/src/app/features/notice_board/notice_board_item.dart';
import 'package:builders_group/src/l10n/app_localizations.dart';
import 'package:builders_group/src/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NoticeBoardView extends StatefulWidget {
  const NoticeBoardView({super.key});

  @override
  State<NoticeBoardView> createState() => _NoticeBoardViewState();
}

class _NoticeBoardViewState extends State<NoticeBoardView> {
  final List<NoticeBoardItem> _notices = [];
  final Random _random = Random();
  List<String> alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
  ];
  final List<String> _loremIpsumSentences = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
    "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.",
    "Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae.",
    "Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula.",
    "Cras ultricies ligula sed magna dictum porta.",
    "Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.",
    "Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum.",
    "Nulla vitae elit libero, a pharetra augue.",
    "Integer posuere erat a ante venenatis dapibus posuere velit aliquet.",
    "Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.",
    "Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.",
  ];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _generateRandomNotices(n: 30);
  }

  String _generateRandomLongText() {
    final int sentenceCount = _random.nextInt(5) + 3;
    String longText = "";
    for (int i = 0; i < sentenceCount; i++) {
      longText +=
          "${_loremIpsumSentences[_random.nextInt(_loremIpsumSentences.length)]} ";
    }
    return longText.trim();
  }

  _generateRandomNotices({int n = 10}) {
    for (int i = 0; i < n; i++) {
      String text = _generateRandomLongText();
      _notices.add(
        NoticeBoardItem(
          profilePicUrl:
              'https://picsum.photos/100/100?random=$i', // Replace with your image URLs
          name: 'Resident ${i + 1}',
          flatNumber:
              '${alphabet[_random.nextInt(alphabet.length)]}-${_random.nextInt(10) + 1}0${_random.nextInt(4) + 1}',
          title:
              _loremIpsumSentences[_random.nextInt(
                _loremIpsumSentences.length,
              )],
          description: text,
          imageUrl:
              _random.nextBool()
                  ? 'https://picsum.photos/500/200?random=${i + 2 * i + 1}'
                  : null, //Or AssetImage

          date: DateTime.now().subtract(Duration(days: _random.nextInt(30))),
          isLiked: _random.nextBool(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('notice_board')),
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (_, index) {
                    final notic = _notices[index];
                    return _buildItem(notic);
                  },
                  itemCount: _notices.length,
                ),
              ),
              // SizedBox(height: 16),
              // _buildFooter(),
              // SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  _buildItem(NoticeBoardItem notice) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          // spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notice.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.titleStyle,
            ),
            SizedBox(height: 8),
            Divider(height: 1),
            SizedBox(height: 8),
            Text(
              notice.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            if (notice.imageUrl != null)
              Column(
                children: [
                  SizedBox(height: 8), //Add space if there is already text.
                  CachedNetworkImage(
                    imageUrl: notice.imageUrl!,
                    maxHeightDiskCache: 200,
                    height: 150,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) {
                      return Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      );
                    },
                  ),
                ],
              ),
            SizedBox(height: 8),
            Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                '${notice.date.day}/${notice.date.month}/${notice.date.year}',
                style: TextStyle(fontSize: 14),
              ),
                TextButton.icon(
                  onPressed: () {},
                  style: ButtonStyle(
                    iconColor: WidgetStateProperty.all(colorScheme.onSurface),
                    foregroundColor: WidgetStateProperty.all(
                      colorScheme.onSurface,
                    ),
                  ),
                  iconAlignment: IconAlignment.end,
                  icon: Icon(Icons.arrow_forward_rounded),
                  label: Text(
                    AppLocalizations.of(context).translate('view_more'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
