import 'package:builders_group/src/app/routes/app_route_name.dart';
import 'package:builders_group/src/l10n/app_localizations.dart';
import 'package:builders_group/src/shared/models/page_arguments.dart';
import 'package:builders_group/src/theme/theme.dart';
import 'package:flutter/material.dart';

class MembersView extends StatefulWidget {
  const MembersView({super.key});

  @override
  State<MembersView> createState() => _MembersViewState();
}

class _MembersViewState extends State<MembersView> {
  final List<String> _blocks = [
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

  final List<Item> _data = [];

  final int _totalFloors = 7;

  @override
  void initState() {
    super.initState();
    for (var b in _blocks) {
      _data.add(Item(block: 'Block $b'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('members')),
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(parent: ScrollPhysics()),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // number of items in each row
                mainAxisSpacing: 8.0, // spacing between rows
                crossAxisSpacing: 8.0, // spacing between columns
              ),
              itemCount: _blocks.length,
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRouteName.residents,
                      arguments: PageArguments(data: {"block": _blocks[index]}),
                    );
                  },
                  child: Card(
                    elevation: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Block', style: AppTheme.subTitleStyle),
                        Text(_blocks[index], style: AppTheme.titleStyle),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = isExpanded;
        });
      },
      children:
          _data.map<ExpansionPanel>((Item item) {
            return ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(title: Text('Block ${item.block}'));
              },
              body: Column(
                children: [
                  for (int i = 0; i < _totalFloors; i++)
                    ListTile(
                      title: Text('Floor ${i + 1}'),
                      trailing: Icon(
                        _data[i].isExpanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_right,
                      ),
                      onTap: () {},
                    ),
                ],
              ),
              isExpanded: item.isExpanded,
            );
          }).toList(),
    );
  }
}

class Item {
  Item({required this.block, this.isExpanded = false});

  String block;
  bool isExpanded;
}
