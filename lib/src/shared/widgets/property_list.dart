import 'package:flutter/material.dart';

class PropertyList extends StatefulWidget {
  const PropertyList({super.key});

  @override
  State<PropertyList> createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {

  String selectedProperty = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Text('$index'),
          ),
          title: Text('Property $index'),
          subtitle: Text('Description $index'),
          onTap: () {
            Navigator.pop(context, 'Property $index');
          },
          // trailing: Icon(Icons.arrow_forward_ios),
        );
      },
    );
  }
}