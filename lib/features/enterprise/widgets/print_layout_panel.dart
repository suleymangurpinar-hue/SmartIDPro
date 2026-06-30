import 'package:flutter/material.dart';

class PrintLayoutPanel extends StatefulWidget {
  const PrintLayoutPanel({super.key});

  @override
  State<PrintLayoutPanel> createState() => _PrintLayoutPanelState();
}

class _PrintLayoutPanelState extends State<PrintLayoutPanel> {
  String paper = "10x15";

  String layout = "8";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color.fromRGBO(255, 255, 255, .06)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "PRINT LAYOUT",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                _paperButton("10x15"),
                _paperButton("13x18"),
                _paperButton("15x21"),
                _paperButton("A4"),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                _layoutButton("4"),
                _layoutButton("6"),
                _layoutButton("8"),
                _layoutButton("12"),
                _layoutButton("Auto"),
              ],
            ),

            const SizedBox(height: 16),

            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: _crossCount(),
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        children: List.generate(
                          _photoCount(),
                          (index) => Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE5E7EB),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 18,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.print, color: Color(0xFFD4A64A), size: 18),
                const SizedBox(width: 8),
                Text(
                  "$layout Adet • $paper",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _paperButton(String value) {
    final active = paper == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            paper = value;
          });
        },
        child: Container(
          height: 36,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            color: active ? const Color(0xFFD4A64A) : const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                color: active ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _layoutButton(String value) {
    final active = layout == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            layout = value;
          });
        },
        child: Container(
          height: 34,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF4F8CFF) : const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  int _photoCount() {
    switch (layout) {
      case "4":
        return 4;

      case "6":
        return 6;

      case "8":
        return 8;

      case "12":
        return 12;

      default:
        return 10;
    }
  }

  int _crossCount() {
    switch (layout) {
      case "4":
        return 2;

      case "6":
        return 3;

      case "8":
        return 4;

      case "12":
        return 4;

      default:
        return 5;
    }
  }
}
