import 'package:builders_group/src/app/routes/app_route_name.dart';
import 'package:builders_group/src/l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ComplaintsView extends StatelessWidget {
  const ComplaintsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('complaints')),
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            itemBuilder: (_, index) {
              return _complaintCard(index, context);
            },
            itemCount: 24,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRouteName.addComplaint);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _complaintCard(index, context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    String status =
        index % 2 == 0
            ? "Open"
            : index % 3 == 0
            ? "In Progress"
            : "Closed";
    IconData icon = Icons.receipt_long_outlined;
    Color color =
        status == 'Open'
            ? Colors.green
            : status == 'In Progress'
            ? Colors.blue
            : Colors.grey;

    return Card(
      margin: EdgeInsets.all(8.0),

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 8,
              children: [
                Icon(Icons.confirmation_number_outlined),
                Text(
                  'Ticket No: CMP0${index + 1}',
                  style: TextStyle(
                    // color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Chip(
                  label: Text(status),
                  labelStyle: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                  // avatar: Icon(icon, color: color),
                  backgroundColor: color.withValues(alpha: 0.17),
                  side: BorderSide(color: color, width: 1),
                ),
              ],
            ),
            Row(
              spacing: 16,
              children: [
                ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: 'https://picsum.photos/100/100?random=$index',
                    width: 120,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                Flexible(
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Complaint $index',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Description -- Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              'Created By: Person' + ' on 12/03/2025 11:05PM',
              style: TextStyle(
                color: colorScheme.onSurface.withValues(alpha: 0.87),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
