import 'package:flutter/material.dart';

class AutoAlignResult {
  final double scale;
  final Offset offset;

  const AutoAlignResult({
    required this.scale,
    required this.offset,
  });
}

class AutoAlignEngine {
  AutoAlignResult calculate({
    required double faceX,
    required double faceY,
    required double faceWidth,
    required double faceHeight,
    required double targetHeadRatio,
    required double targetEyeRatio,
  }) {
    final currentHeadRatio = faceHeight;

    final scale =
        currentHeadRatio == 0
            ? 1.0
            : targetHeadRatio / currentHeadRatio;

    final faceCenterX =
        faceX + (faceWidth / 2);

    final eyesY =
        faceY + (faceHeight * 0.38);

    final dx =
        (0.5 - faceCenterX) * 600;

    final dy =
        (targetEyeRatio - eyesY) * 800;

    return AutoAlignResult(
      scale: scale.clamp(
        0.7,
        2.5,
      ),
      offset: Offset(dx, dy),
    );
  }
}