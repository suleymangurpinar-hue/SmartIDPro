import 'package:flutter/material.dart';
import '../../../shared/animations/gold_border_card.dart';

class TopToolbar extends StatelessWidget {
  const TopToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return GoldBorderCard(
      radius: 28,
      child: Container(
        height: 86,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF131A26),
          borderRadius: BorderRadius.circular(28),
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            _Tool(
              Icons.file_upload_outlined,
              "Import",
              true,
            ),
            _Tool(
              Icons.crop_outlined,
              "Crop",
            ),
            _Tool(
              Icons.auto_fix_high_outlined,
              "Retouch",
            ),
            _Tool(
              Icons.wallpaper_outlined,
              "Background",
            ),
            _Tool(
              Icons.psychology_alt_outlined,
              "AI",
            ),
            _Tool(
              Icons.center_focus_strong_outlined,
              "Align",
            ),
            _Tool(
              Icons.verified_user_outlined,
              "ICAO",
            ),
            _Tool(
              Icons.print_outlined,
              "Print",
            ),
            _Tool(
              Icons.upload_outlined,
              "Export",
            ),
          ],
        ),
      ),
    );
  }
}

class _Tool extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool active;

  const _Tool(
    this.icon,
    this.title, [
    this.active = false,
  ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      margin: const EdgeInsets.only(
        right: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: active
            ? const Color(0xFF5EA1FF)
            : const Color(0xFF1A2233),
        boxShadow: active
            ? const [
                BoxShadow(
                  color: Color(0x335EA1FF),
                  blurRadius: 24,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 22,
            color: active
                ? Colors.white
                : Colors.white70,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight:
                  FontWeight.w600,
              color: active
                  ? Colors.white
                  : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}