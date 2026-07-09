import 'package:flutter/material.dart';

import '../models/clothing_item.dart';
import 'clothing_card.dart';

class ClothingGrid extends StatelessWidget {
  const ClothingGrid({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onSelected,
  });

  final List<ClothingItem> items;
  final ClothingItem? selectedItem;
  final ValueChanged<ClothingItem> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: .78,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return ClothingCard(
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
