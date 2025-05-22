import 'package:flutter/material.dart';

class ResidentList extends StatefulWidget {
  final String block;
  const ResidentList({super.key, required this.block});

  @override
  State<ResidentList> createState() => _ResidentListState();
}

class _ResidentListState extends State<ResidentList> {
  final int _totalFloors = 7;
  List<Item> _data = [];

  @override
  void initState() {
    super.initState();
    _data = List.generate(_totalFloors, (index) {
      return Item(floor: index + 1, isExpanded: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Block ${widget.block}')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: _buildPanel(),
            ),
          ),
        ],
      ),
    );
  }

  _buildPanel() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 12,
            color: Color.fromRGBO(0, 0, 0, 0.16),
          ),
        ],
      ),
      margin: EdgeInsets.all(8),
      child: ExpansionPanelList(
        elevation:8,
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
                  return ListTile(title: Text('Floor ${item.floor}'));
                },
                body: Column(
                  children: [
                    for (int i = 0; i < 6; i++)
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('$i'),),
                        title: Text('Random Name'),
                        subtitle: Text('${widget.block}-${item.floor}0${i+1}'),
                        onTap: () {},
                      ),
                  ],
                ),
                isExpanded: item.isExpanded,
              );
            }).toList(),
      ),
    );
  }
}

class Item {
  Item({required this.floor, this.isExpanded = false});

  int floor;
  bool isExpanded;
}
