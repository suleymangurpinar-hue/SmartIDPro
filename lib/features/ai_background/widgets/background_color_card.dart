import 'package:flutter/material.dart';

import '../models/background_item.dart';

class BackgroundColorCard extends StatelessWidget {
  const BackgroundColorCard({
    super.key,
    required this.item,
    required this.active,
    required this.onTap,
  });

  final BackgroundItem item;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active ? const Color(0xFFD4A64A) : Colors.transparent,
            width: 3,
          ),
        ),
      ),
    );
  }
}
