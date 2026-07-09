import 'package:flutter/material.dart';

import '../models/clothing_result.dart';

class EngineStatusChip extends StatelessWidget {
  const EngineStatusChip({super.key, required this.status});

  final ClothingStatus status;

  @override
  Widget build(BuildContext context) {
    return Text(
      _label,
      style: const TextStyle(
        color: Colors.white54,
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    );
  }

  String get _label {
    switch (status) {
      case ClothingStatus.idle:
        return 'READY';
      case ClothingStatus.preparing:
      case ClothingStatus.processing:
        return 'PROCESSING';
      case ClothingStatus.completed:
        return 'COMPLETED';
      case ClothingStatus.failed:
        return 'FAILED';
    }
  }
}
