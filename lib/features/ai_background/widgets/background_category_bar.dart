import 'package:flutter/material.dart';

import '../models/background_category.dart';

class BackgroundCategoryBar extends StatelessWidget {
  const BackgroundCategoryBar({
    super.key,
    required this.currentCategory,
    required this.onCategoryChanged,
  });

  final BackgroundCategory currentCategory;
  final ValueChanged<BackgroundCategory> onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
