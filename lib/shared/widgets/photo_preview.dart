import 'package:flutter/material.dart';

class PhotoPreview extends StatelessWidget {
  const PhotoPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [Color(0xFF101826), Color(0xFF0A101A)],
        ),
        border: Border.all(color: const Color(0xFF24344D)),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.add_photo_alternate,
                  size: 90,
                  color: Colors.white38,
                ),
                SizedBox(height: 20),
                Text(
                  "DROP PHOTO HERE",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Positioned(top: 30, left: 30, child: _chip('RAW Ready')),
          Positioned(top: 30, right: 30, child: _chip('AI Ready')),
        ],
      ),
    );
  }

  static Widget _chip(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xAA111A2A),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(title),
    );
  }
}
