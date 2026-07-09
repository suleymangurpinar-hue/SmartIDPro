import 'package:flutter/material.dart';

import '../models/background_result.dart';

class EngineStatusChip extends StatelessWidget {
  const EngineStatusChip({super.key, required this.status});

  final BackgroundStatus status;

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
      case BackgroundStatus.idle:
        return 'READY';
      case BackgroundStatus.preparing:
      case BackgroundStatus.processing:
        return 'PROCESSING';
      case BackgroundStatus.completed:
        return 'COMPLETED';
      case BackgroundStatus.failed:
        return 'FAILED';
    }
  }
}
