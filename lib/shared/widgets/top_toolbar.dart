import 'package:flutter/material.dart';

class TopToolbar extends StatelessWidget {
  const TopToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1420),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1E2A40)),
      ),
      child: Row(
        children: [
          const Text(
            'SMART ID PRO',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
          const Spacer(),
          _btn(Icons.photo_library_outlined, 'Import'),
          _btn(Icons.crop, 'Crop'),
          _btn(Icons.face_retouching_natural, 'Retouch'),
          _btn(Icons.badge, 'Biometric'),
          _btn(Icons.print, 'Print'),
          _btn(Icons.download, 'Export'),
        ],
      ),
    );
  }

  static Widget _btn(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF151E2F),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [Icon(icon, size: 18), const SizedBox(width: 6), Text(title)],
      ),
    );
  }
}
