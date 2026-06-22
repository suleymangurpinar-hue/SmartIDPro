import 'package:flutter/material.dart';

class FaceLandmark {
  final double x;
  final double y;

  const FaceLandmark({
    required this.x,
    required this.y,
  });

  Offset toOffset(
    Size size,
  ) {
    return Offset(
      size.width * x,
      size.height * y,
    );
  }
}