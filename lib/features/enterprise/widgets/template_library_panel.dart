import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../print_studio/providers/print_studio_provider.dart';
import '../providers/document_preset_provider.dart';
import '../services/document_presets.dart';

class TemplateLibraryPanel extends StatefulWidget {
  const TemplateLibraryPanel({super.key});

  @override
  State<TemplateLibraryPanel> createState() =>
      _TemplateLibraryPanelState();
}

class _TemplateLibraryPanelState
    extends State<TemplateLibraryPanel> {
  String selectedCategory = 'Türkiye';
  String selectedTemplate = '';

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Türkiye',
      'Europe',
      'America',
      'Asia',
      'Middle East',
    ];

    final templates =
        _templates[selectedCategory] ?? [];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: const Color.fromRGBO(
            255,
            255,
            255,
            .06,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'TEMPLATE LIBRARY',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 38,
              child: ListView(
                scrollDirection:
                    Axis.horizontal,
                children:
                    categories.map((category) {
                  final active =
                      selectedCategory ==
                          category;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory =
                            category;
                      });
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(
                        right: 8,
                      ),
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),
                      decoration:
                          BoxDecoration(
                        color: active
                            ? const Color(
                                0xFFD4A64A,
                              )
                            : const Color(
                                0xFF1F2937,
                              ),
                        borderRadius:
                            BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style:
                              TextStyle(
                            color: active
                                ? Colors.black
                                : Colors.white,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: GridView.builder(
                itemCount:
                    templates.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.6,
                ),
                itemBuilder:
                    (context, index) {
                  final title =
                      templates[index];

                  final active =
                      selectedTemplate ==
                          title;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTemplate =
                            title;
                      });

                      final print =
                          context.read<
                              PrintStudioProvider>();

                      final preset =
                          context.read<
                              DocumentPresetProvider>();

                      if (title.contains(
                        'Biyometrik',
                      )) {
                        preset.changePreset(
                          DocumentPresets
                              .turkeyBiometric,
                        );

                        print.applyPreset(
                          paperSize:
                              '10x15',
                          photoLayout:
                              4,
                        );
                      } else if (title
                          .contains(
                        'Vesikalık',
                      )) {
                        preset.changePreset(
                          DocumentPresets
                              .turkeyPassport,
                        );

                        print.applyPreset(
                          paperSize:
                              '10x15',
                          photoLayout:
                              8,
                        );
                      } else if (title
                          .contains(
                        'Kimlik',
                      )) {
                        preset.changePreset(
                          DocumentPresets
                              .turkeyIdentity,
                        );

                        print.applyPreset(
                          paperSize:
                              '10x15',
                          photoLayout:
                              4,
                        );
                      } else if (title
                          .contains(
                        'Ehliyet',
                      )) {
                        preset.changePreset(
                          DocumentPresets
                              .turkeyDriver,
                        );

                        print.applyPreset(
                          paperSize:
                              '10x15',
                          photoLayout:
                              4,
                        );
                      } else if (title
                          .contains(
                        'Nikah',
                      )) {
                        preset.changePreset(
                          DocumentPresets
                              .turkeyMarriage,
                        );

                        print.applyPreset(
                          paperSize:
                              '10x15',
                          photoLayout:
                              8,
                        );
                      } else if (title
                          .contains(
                        'USA',
                      )) {
                        preset.changePreset(
                          DocumentPresets
                              .usaVisa,
                        );

                        print.applyPreset(
                          paperSize:
                              '10x15',
                          photoLayout:
                              4,
                        );
                      } else if (title
                          .contains(
                        'Schengen',
                      )) {
                        preset.changePreset(
                          DocumentPresets
                              .schengenVisa,
                        );

                        print.applyPreset(
                          paperSize:
                              '10x15',
                          photoLayout:
                              8,
                        );
                      }
                    },
                    child: AnimatedContainer(
                      duration:
                          const Duration(
                        milliseconds:
                            200,
                      ),
                      decoration:
                          BoxDecoration(
                        color: active
                            ? const Color(
                                0xFFD4A64A,
                              )
                            : const Color(
                                0xFF1F2937,
                              ),
                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),
                        border:
                            active
                                ? Border.all(
                                    color:
                                        Colors.white,
                                  )
                                : null,
                      ),
                      child: Center(
                        child: Text(
                          title,
                          textAlign:
                              TextAlign.center,
                          style:
                              TextStyle(
                            color: active
                                ? Colors.black
                                : Colors.white,
                            fontSize: 11,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const Map<
      String,
      List<String>> _templates = {
    'Türkiye': [
      'Biyometrik 50x60',
      'Vesikalık 45x60',
      'Kimlik',
      'Ehliyet',
      'Öğrenci Kartı',
      'Nikah Dairesi',
      'Pasaport',
      'Memur Kimliği',
    ],
    'Europe': [
      'Schengen',
      'Germany Visa',
      'France Visa',
      'Italy Visa',
      'Spain Visa',
      'Netherlands',
      'Belgium',
      'Austria',
    ],
    'America': [
      'USA Visa',
      'Green Card',
      'Canada Visa',
      'Mexico Visa',
    ],
    'Asia': [
      'Japan Visa',
      'China Visa',
      'Korea Visa',
      'Singapore Visa',
    ],
    'Middle East': [
      'Dubai Visa',
      'Saudi Visa',
      'Qatar Visa',
      'Kuwait Visa',
    ],
  };
}