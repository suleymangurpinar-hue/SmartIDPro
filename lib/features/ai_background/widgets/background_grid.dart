import 'package:flutter/material.dart';

import '../models/background_item.dart';
import 'background_color_card.dart';

class BackgroundGrid extends StatelessWidget {
  const BackgroundGrid({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onSelected,
  });

  final List<BackgroundItem> items;
  final BackgroundItem? selectedItem;
  final ValueChanged<BackgroundItem> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return BackgroundColorCard(
          item: item,
          active: selectedItem == item,
          onTap: () {
            onSelected(item);
          },
        );
      },
    );
  }
}
