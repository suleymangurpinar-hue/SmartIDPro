import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../print_studio/providers/print_studio_provider.dart';
import '../providers/document_preset_provider.dart';
import '../services/document_presets.dart';

class DocumentPresetBar extends StatelessWidget {
  const DocumentPresetBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DocumentPresetProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          height: 54,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: DocumentPresets.all.map((preset) {
              final active =
                  provider.selected == preset;

              return GestureDetector(
                onTap: () {
                  provider.changePreset(preset);

                  context
                      .read<PrintStudioProvider>()
                      .applyPreset(
                        paperSize:
                            provider.paperSize,
                        photoLayout: provider
                            .autoLayout
                            .toString(),
                      );
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(
                    right: 10,
                  ),
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  decoration: BoxDecoration(
                    color: active
                        ? const Color(
                            0xFFD4A64A,
                          )
                        : const Color(
                            0xFF182232,
                          ),
                    borderRadius:
                        BorderRadius.circular(
                      16,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      preset.name,
                      style: TextStyle(
                        color: active
                            ? Colors.black
                            : Colors.white70,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}