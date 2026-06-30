import 'package:flutter/material.dart';

class PrintPreview extends StatelessWidget {
  const PrintPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: const Color(0xFF0E1420),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFF1D2A40)),
      ),
      child: const Center(
        child: Text(
          'PRINT LAYOUT PREVIEW',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
