import 'package:builders_group/src/theme/theme.dart';
import 'package:flutter/material.dart';

class ModalService {

  static Future modalBottomSheet(context, child, title,
      {double? maxHeight, double initialSize = 0.8, double minSize = 0.5}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      elevation: 8.0,
      backgroundColor: Colors.transparent, // Make background transparent
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: initialSize, // Initial height is 50%
        minChildSize: minSize, // Minimum height is 50%
        maxChildSize: 1.0, // Maximum height is 100%
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    children: [
                      IconButton(
                        onPressed: () =>
                            ModalService.closeBottomSheet(context),
                        icon: Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                      Text(title, style: AppTheme.titleStyle),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: child,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static PersistentBottomSheetController bottomSheet(context, child,
      {double? maxHeight}) {
    return showBottomSheet(
      context: context,
      elevation: 8.0,
      constraints:
          maxHeight != null ? BoxConstraints(maxHeight: maxHeight) : null,
      builder: (context) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: child),
    );
  }

  static closeBottomSheet(context) {
    Navigator.pop(context);
  }
}