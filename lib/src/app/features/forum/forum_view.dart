import 'dart:math';

import 'package:builders_group/src/app/features/forum/forum_presenter.dart';
import 'package:builders_group/src/app/features/forum/forum_item.dart';
import 'package:builders_group/src/l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ForumView extends StatefulWidget {
  const ForumView({super.key});

  @override
  State<ForumView> createState() => _ForumViewState();
}

class _ForumViewState extends State<ForumView> implements ForumContract {
  List<ForumItem> _forums = [];
  List<ForumItem> _filteredForums = [];
  Random _random = Random();
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

  bool fourPlusRating = false;
  bool showCricket = false;
  bool showBadminton = false;
  bool showPickleBall = false;
  bool showTableTennis = false;
  String _sort = 'default';

  @override
  void initState() {
    super.initState();
    _generateRandomForums(n: 30);
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

  void _generateRandomForums({int n = 10}) {
    for (int i = 0; i < n; i++) {
      String? text = _random.nextBool() ? _generateRandomLongText() : null;
      _forums.add(
        ForumItem(
          profilePicUrl:
              'https://picsum.photos/100/100?random=$i', // Replace with your image URLs
          name: 'Resident ${i + 1}',
          flatNumber:
              '${alphabet[_random.nextInt(alphabet.length)]}-${_random.nextInt(10) + 1}0${_random.nextInt(4) + 1}',
          forumText: text,
          forumImageUrl:
              _random.nextBool()
                  ? 'https://picsum.photos/500/200?random=${i + 2 * i + 1}'
                  : text == null
                  ? 'https://picsum.photos/500/200?random=${i + 2 * i + 1}'
                  : null, //Or AssetImage

          date: DateTime.now().subtract(Duration(days: _random.nextInt(30))),
          isLiked: _random.nextBool(),
        ),
      );
    }
    _filteredForums = [..._forums];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('forum')),
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
                    final forum = _filteredForums[index];
                    return _buildItem(forum);
                  },
                  itemCount: _filteredForums.length,
                ),
              ),
              SizedBox(height: 16),
              _buildFooter(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  _buildFilters() {
    return SizedBox(
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          MenuAnchor(
            menuChildren: <Widget>[
              _buildRadioMenu('default', 'Relevance'),
              _buildRadioMenu('price_asc', 'Price per hour'),
              _buildRadioMenu('ratings', 'Ratings'),
              _buildRadioMenu('distance', 'Distance'),
            ],
            builder: (
              BuildContext context,
              MenuController controller,
              Widget? child,
            ) {
              return _filterAndSortChip(
                'Sort By',
                const Icon(Icons.sort_rounded, color: null),
                false,
                _sort != 'default',
                () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                () {},
              );
            },
          ),
          SizedBox(width: 8),
          _filterAndSortChip(
            'Nearest',
            null,
            true,
            _sort == 'distance',
            () {
              setState(() {
                if (_sort == 'distance') {
                  _sort = 'default';
                } else {
                  _sort = 'distance';
                }
              });
            },
            () {
              setState(() {
                _sort = 'default';
              });
            },
          ),
          SizedBox(width: 8),
          _filterAndSortChip(
            'Rating 4.0+',
            null,
            true,
            fourPlusRating,
            () {
              setState(() {
                fourPlusRating = !fourPlusRating;
              });
            },
            () {
              setState(() {
                fourPlusRating = false;
              });
            },
          ),
          SizedBox(width: 8),
          _filterAndSortChip(
            'Cricket',
            null,
            true,
            showCricket,
            () {
              setState(() {
                showCricket = !showCricket;
              });
              _applyFilters();
            },
            () {
              setState(() {
                showCricket = false;
              });
              _applyFilters();
            },
          ),
          SizedBox(width: 8),
          _filterAndSortChip(
            'Badminton',
            null,
            true,
            showBadminton,
            () {
              setState(() {
                showBadminton = !showBadminton;
              });
              _applyFilters();
            },
            () {
              setState(() {
                showBadminton = false;
              });
              _applyFilters();
            },
          ),
          SizedBox(width: 8),
          _filterAndSortChip(
            'PickleBall',
            null,
            true,
            showPickleBall,
            () {
              setState(() {
                showPickleBall = !showPickleBall;
              });
              _applyFilters();
            },
            () {
              setState(() {
                showPickleBall = false;
              });
              _applyFilters();
            },
          ),
          SizedBox(width: 8),
          _filterAndSortChip(
            'TableTennis',
            null,
            true,
            showTableTennis,
            () {
              setState(() {
                showTableTennis = !showTableTennis;
              });
              _applyFilters();
            },
            () {
              setState(() {
                showTableTennis = false;
              });
              _applyFilters();
            },
          ),
        ],
      ),
    );
  }

  _applyFilters() {
    dynamic filters = {};
    if (showCricket) {
      filters['cricket'] = true;
    }
    if (showBadminton) {
      filters['badminton'] = true;
    }
    if (showPickleBall) {
      filters['pickleball'] = true;
    }
    if (showTableTennis) {
      filters['tabletennis'] = true;
    }
    // _presenter.loadVenues(filters: filters);
  }

  _buildRadioMenu(String value, String label) {
    return RadioMenuButton(
      value: value,
      groupValue: _sort,
      onChanged: (String? value) {
        setState(() {
          _sort = value!;
        });
      },
      child: Text(label),
    );
  }

  _filterAndSortChip(
    String label,
    Widget? avatar,
    bool isDeletable,
    bool active,
    onPressed,
    onDeleted,
  ) {
    // ColorScheme colorScheme = Theme.of(context).colorScheme;
    return InputChip(
      label: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      padding: EdgeInsets.only(left: 8, right: 8),
      labelPadding: EdgeInsets.only(left: 4, right: 4),
      color:
          active
              ? WidgetStateProperty.all(
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.17),
              )
              : null,
      avatar: avatar,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        side: BorderSide(
          width: 1,
          color:
              active ? Theme.of(context).colorScheme.primary : Colors.black26,
        ),
      ),
      onPressed: onPressed,
      onDeleted: isDeletable && active ? onDeleted : null,
    );
  }

  _buildItem(ForumItem forum) {
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
            ListTile(
              minVerticalPadding: 0,
              minTileHeight: 40,
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  forum.profilePicUrl,
                ),
              ),
              contentPadding: EdgeInsets.zero,
              title: Text(
                forum.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(forum.flatNumber),
              trailing: Text(
                '${forum.date.day}/${forum.date.month}/${forum.date.year}',
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 8),
            if (forum.forumText != null)
              Text(
                forum.forumText!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            if (forum.forumImageUrl != null)
              Column(
                children: [
                  if (forum.forumText != null)
                    SizedBox(height: 8), //Add space if there is already text.
                  CachedNetworkImage(
                    imageUrl: forum.forumImageUrl!,
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
            Divider(height: 1),
            Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      forum.isLiked = !forum.isLiked;
                    });
                  },

                  style: ButtonStyle(
                    iconColor: WidgetStateProperty.all(
                      forum.isLiked
                          ? colorScheme.primary
                          : colorScheme.onSurface,
                    ),
                    foregroundColor: WidgetStateProperty.all(
                      forum.isLiked
                          ? colorScheme.primary
                          : colorScheme.onSurface,
                    ),
                  ),
                  child: Row(
                    spacing: 16,
                    children: [
                      Icon(
                        forum.isLiked
                            ? Icons.thumb_up
                            : Icons.thumb_up_outlined,
                      ),
                      Text(
                        forum.isLiked
                            ? AppLocalizations.of(context).translate('liked')
                            : AppLocalizations.of(context).translate('like'),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    iconColor: WidgetStateProperty.all(colorScheme.onSurface),
                    foregroundColor: WidgetStateProperty.all(
                      colorScheme.onSurface,
                    ),
                  ),
                  child: Row(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.comment_outlined),
                      Text(AppLocalizations.of(context).translate('comment')),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    iconColor: WidgetStateProperty.all(colorScheme.onSurface),
                    foregroundColor: WidgetStateProperty.all(
                      colorScheme.onSurface,
                    ),
                  ),
                  child: Row(
                    spacing: 16,
                    children: [
                      Icon(Icons.share_rounded),
                      Text(AppLocalizations.of(context).translate('share')),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildFooter() {
    return Row(
      spacing: 8,
      children: [
        Expanded(child: _searchBar()),
        OutlinedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.add_comment_outlined),
          label: Text(AppLocalizations.of(context).translate('post')),
        ),
      ],
    );
  }

  _searchBar() {
    return SearchAnchor.bar(
      barHintText: AppLocalizations.of(context).translate('search'),
      barElevation: WidgetStateProperty.all(0),
      constraints: BoxConstraints(minHeight: 48),
      suggestionsBuilder: (_, c) {
        final searchedText = c.value.text.trim().toLowerCase();
        if (searchedText.isEmpty) {
          return [_recentSearches()];
        }
        final filteredForums =
            _forums
                .where(
                  (n) =>
                      searchedText.length >= 3 &&
                      (n.name.toLowerCase().contains(searchedText) ||
                          (n.forumText != null &&
                              n.forumText!.toLowerCase().contains(
                                searchedText,
                              ))),
                )
                .toList();
        return filteredForums.isNotEmpty
            ? filteredForums.map((e) => _buildItem(e))
            : [Center(child: Text('No Data'))];
      },
    );
  }

  _recentSearches() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 16,
        children: [
          Chip(avatar: Icon(Icons.search), label: Text('Notice 1')),
          Chip(avatar: Icon(Icons.search), label: Text('Notice 2')),
          Chip(avatar: Icon(Icons.search), label: Text('Notice 3')),
          Chip(avatar: Icon(Icons.search), label: Text('Notice 4')),
        ],
      ),
    );
  }
}
