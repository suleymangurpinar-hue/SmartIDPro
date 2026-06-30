import 'package:flutter/material.dart';

class ImportDropZone extends StatelessWidget {
  final VoidCallback onImport;

  const ImportDropZone({super.key, required this.onImport});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onImport,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),
    );
  }
}
