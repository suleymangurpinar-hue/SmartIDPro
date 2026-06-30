import 'package:flutter/material.dart';

import '../../shared/widgets/sidebar_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B14),
      body: SafeArea(
        child: Row(
          children: [
            const SidebarWidget(),

            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFF182235)),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "SMART ID PRO",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const Spacer(),

                        _toolButton(Icons.upload, "Import"),
                        _toolButton(Icons.crop, "Crop"),
                        _toolButton(Icons.auto_fix_high, "AI"),
                        _toolButton(Icons.badge, "Biometric"),
                        _toolButton(Icons.print, "Print"),
                        _toolButton(Icons.download, "Export"),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0E1525),
                                      borderRadius: BorderRadius.circular(28),
                                      border: Border.all(
                                        color: const Color(0xFF1A2944),
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.add_photo_alternate_outlined,
                                            size: 90,
                                            color: Colors.white54,
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            "DROP PHOTO HERE",
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "RAW • CR3 • ARW • RAF • DNG • JPG",
                                            style: TextStyle(
                                              color: Colors.white54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0E1525),
                                      borderRadius: BorderRadius.circular(28),
                                      border: Border.all(
                                        color: const Color(0xFF1A2944),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "LIVE PRINT PREVIEW",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 20),

                          Container(
                            width: 320,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0E1525),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: const Color(0xFF1A2944),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(22),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "AI CONTROL CENTER",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 25),

                                  _panelCard(
                                    "Background",
                                    "White / Blue / Gray",
                                  ),

                                  _panelCard("Biometric", "ISO / ICAO Rules"),

                                  _panelCard(
                                    "Face Retouch",
                                    "0 - 100 Strength",
                                  ),

                                  _panelCard(
                                    "Dress AI",
                                    "Suit / Shirt / Formal",
                                  ),

                                  _panelCard(
                                    "Face Align",
                                    "Eye & Head Detection",
                                  ),

                                  _panelCard(
                                    "Print Layout",
                                    "4x, 6x, 8x Sheet",
                                  ),

                                  const Spacer(),

                                  SizedBox(
                                    width: double.infinity,
                                    height: 58,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("PROCESS PHOTO"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _toolButton(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF111A2B),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
      ),
    );
  }

  static Widget _panelCard(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF131D31),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFF2E6BFF),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(subtitle, style: const TextStyle(color: Colors.white54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
