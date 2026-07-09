import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../compliance/services/face_detector_service.dart';
import '../../print_studio/providers/print_studio_provider.dart';
import '../providers/document_preset_provider.dart';
import '../providers/workspace_provider.dart';
import '../services/document_presets.dart';

class TemplateLibraryPanel extends StatefulWidget {
  const TemplateLibraryPanel({
    super.key,
  });

  @override
  State<TemplateLibraryPanel> createState() =>
      _TemplateLibraryPanelState();
}

class _TemplateLibraryPanelState
    extends State<TemplateLibraryPanel> {
  String _selectedCountry = 'Türkiye';

  DocumentPreset? _selectedPreset =
      DocumentPresets.turkeyBiometric;

  final Map<String, List<DocumentPreset>>
      _groups = {
    'Türkiye': [
      DocumentPresets.turkeyBiometric,
      DocumentPresets.turkeyPassport,
      DocumentPresets.turkeyIdentity,
      DocumentPresets.turkeyDriver,
      DocumentPresets.turkeyStudent,
      DocumentPresets.turkeyMarriage,
      DocumentPresets.turkeyOfficer,
    ],
    'Avrupa': [
      DocumentPresets.schengenVisa,
      DocumentPresets.germanyVisa,
      DocumentPresets.franceVisa,
      DocumentPresets.italyVisa,
    ],
    'Amerika': [
      DocumentPresets.usaVisa,
      DocumentPresets.canadaVisa,
      DocumentPresets.mexicoVisa,
    ],
    'Asya': [
      DocumentPresets.japanVisa,
      DocumentPresets.chinaVisa,
      DocumentPresets.koreaVisa,
      DocumentPresets.singaporeVisa,
    ],
    'Orta Doğu': [
      DocumentPresets.dubaiVisa,
      DocumentPresets.saudiVisa,
      DocumentPresets.qatarVisa,
      DocumentPresets.kuwaitVisa,
    ],
  };

  Future<void> _applyPreset(
    BuildContext context,
    DocumentPreset preset,
  ) async {
    final presetProvider =
        context.read<DocumentPresetProvider>();

    presetProvider.changePreset(
      preset,
    );

    final print =
        context.read<PrintStudioProvider>();

    print.applyPreset(
      paperSize: preset.paper,
      photoLayout:
          preset.layout.toString(),
    );

    print.setPhotoSize(
      preset.widthMm,
      preset.heightMm,
    );

    final workspace =
        context.read<WorkspaceProvider>();

    final imagePath =
        workspace.imagePath;

    if (imagePath == null) {
      return;
    }

    final face =
        await FaceDetectorService()
            .detectFace(
      imagePath,
    );

    if (!face.faceFound) {
      return;
    }

    workspace.calculateAutoCrop(
      faceX: face.x,
      faceY: face.y,
      faceWidth: face.width,
      faceHeight: face.height,
      targetHeadRatio:
          presetProvider
              .targetHeadRatio,
      targetEyeRatio:
          presetProvider
              .targetEyeRatio,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final presets =
        _groups[_selectedCountry] ??
            [];

    final activePreset =
        _selectedPreset ??
            presets.first;

    return Container(
      decoration: BoxDecoration(
        color:
            const Color(0xFF111827),
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
      child: Padding(
        padding:
            const EdgeInsets.all(10),
        child:
            SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,
            children: [
              const Text(
                'BELGE ŞABLONLARI',
                style: TextStyle(
                  color:
                      Colors.white,
                  fontSize: 16,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Ülke',
                style: TextStyle(
                  color:
                      Colors.white70,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              _dropdown<String>(
                value:
                    _selectedCountry,
                items:
                    _groups.keys
                        .toList(),
                labelBuilder:
                    (e) => e,
                onChanged:
                    (v) async {
                  setState(() {
                    _selectedCountry =
                        v;
                    _selectedPreset =
                        _groups[v]!
                            .first;
                  });

                  await _applyPreset(
                    context,
                    _selectedPreset!,
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Belge Türü',
                style: TextStyle(
                  color:
                      Colors.white70,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              _dropdown<DocumentPreset>(
                value:
                    activePreset,
                items: presets,
                labelBuilder:
                    (e) => e.name,
                onChanged:
                    (v) async {
                  setState(() {
                    _selectedPreset =
                        v;
                  });

                  await _applyPreset(
                    context,
                    v,
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width:
                    double.infinity,
                padding:
                    const EdgeInsets.all(
                  12,
                ),
                decoration:
                    BoxDecoration(
                  color:
                      const Color(
                    0xFF1E293B,
                  ),
                  borderRadius:
                      BorderRadius
                          .circular(
                    16,
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      activePreset
                          .name,
                      style:
                          const TextStyle(
                        color: Colors
                            .white,
                        fontWeight:
                            FontWeight
                                .bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _info(
                      'Ölçü',
                      '${activePreset.widthMm.toInt()} x ${activePreset.heightMm.toInt()} mm',
                    ),
                    _info(
                      'Baskı',
                      activePreset.paper,
                    ),
                    _info(
                      'Yerleşim',
                      '${activePreset.layout} Adet',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _info(
    String title,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style:
                  const TextStyle(
                color:
                    Colors.white54,
                fontSize: 13,
              ),
            ),
          ),
          Text(
            value,
            style:
                const TextStyle(
              color:
                  Colors.white,
              fontSize: 13,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropdown<T>({
    required T value,
    required List<T> items,
    required String Function(T)
        labelBuilder,
    required ValueChanged<T>
        onChanged,
  }) {
    return Container(
      height: 46,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      decoration:
          BoxDecoration(
        color:
            const Color(
          0xFF1E293B,
        ),
        borderRadius:
            BorderRadius.circular(
          14,
        ),
      ),
      child: DropdownButton<T>(
        value: value,
        isExpanded: true,
        underline:
            const SizedBox(),
        dropdownColor:
            const Color(
          0xFF1E293B,
        ),
        style:
            const TextStyle(
          color: Colors.white,
        ),
        items: items
            .map(
              (e) =>
                  DropdownMenuItem<T>(
                value: e,
                child: Text(
                  labelBuilder(
                    e,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (v) {
          if (v != null) {
            onChanged(v);
          }
        },
      ),
    );
  }
}