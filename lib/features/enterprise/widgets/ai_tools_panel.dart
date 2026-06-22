import 'package:flutter/material.dart';

import 'ai_retouch_panel.dart';
import 'ai_clothing_panel.dart';
import 'background_panel.dart';

class AiToolsPanel extends StatefulWidget {
  const AiToolsPanel({
    super.key,
  });

  @override
  State<AiToolsPanel> createState() =>
      _AiToolsPanelState();
}

class _AiToolsPanelState
    extends State<AiToolsPanel> {
  int openedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(
          0xFF111827,
        ),
        borderRadius:
            BorderRadius.circular(
          24,
        ),
        border: Border.all(
          color:
              const Color.fromRGBO(
            255,
            255,
            255,
            .06,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            padding:
                const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color:
                      Color(
                    0xFFD4A64A,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "AI TOOLS",
                  style: TextStyle(
                    color:
                        Colors.white,
                    fontSize: 15,
                    fontWeight:
                        FontWeight.bold,
                    letterSpacing:
                        1,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child:
                SingleChildScrollView(
              padding:
                  const EdgeInsets.only(
                bottom: 12,
              ),
              child: Column(
                children: [
                  _section(
                    0,
                    "AI RETOUCH",
                    const Padding(
                      padding:
                          EdgeInsets.all(
                        12,
                      ),
                      child:
                          AiRetouchPanel(),
                    ),
                  ),

                  _section(
                    1,
                    "AI CLOTHING",
                    const Padding(
                      padding:
                          EdgeInsets.all(
                        12,
                      ),
                      child:
                          AiClothingPanel(),
                    ),
                  ),

                  _section(
                    2,
                    "BACKGROUND",
                    const Padding(
                      padding:
                          EdgeInsets.all(
                        12,
                      ),
                      child:
                          BackgroundPanel(),
                    ),
                  ),

                  _section(
                    3,
                    "ICAO FIX",
                    _comingSoon(),
                  ),

                  _section(
                    4,
                    "EXPORT",
                    _comingSoon(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(
    int index,
    String title,
    Widget child,
  ) {
    final expanded =
        openedIndex == index;

    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              openedIndex = index;
            });
          },
          child: Container(
            height: 52,
            padding:
                const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: Row(
              children: [
                Icon(
                  expanded
                      ? Icons
                          .keyboard_arrow_down
                      : Icons
                          .keyboard_arrow_right,
                  color:
                      const Color(
                    0xFFD4A64A,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    title,
                    style:
                        const TextStyle(
                      color:
                          Colors.white,
                      fontWeight:
                          FontWeight.w600,
                      letterSpacing:
                          1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        AnimatedSize(
          duration:
              const Duration(
            milliseconds: 250,
          ),
          curve:
              Curves.easeInOut,
          child: expanded
              ? child
              : const SizedBox(),
        ),

        Container(
          height: 1,
          color: const Color(
            0x22FFFFFF,
          ),
        ),
      ],
    );
  }

  Widget _comingSoon() {
    return Container(
      padding:
          const EdgeInsets.all(
        20,
      ),
      child: const Text(
        "Coming Soon",
        style: TextStyle(
          color:
              Colors.white54,
        ),
      ),
    );
  }
}