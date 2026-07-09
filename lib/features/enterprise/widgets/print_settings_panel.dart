import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../print_studio/providers/print_studio_provider.dart';

class PrintSettingsPanel extends StatefulWidget {
  const PrintSettingsPanel({
    super.key,
  });

  @override
  State<PrintSettingsPanel> createState() =>
      _PrintSettingsPanelState();
}

class _PrintSettingsPanelState
    extends State<PrintSettingsPanel> {
  bool autoCrop = true;
  bool autoAlign = true;

  @override
  Widget build(BuildContext context) {
    final print =
        context.watch<PrintStudioProvider>();

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius:
            BorderRadius.circular(24),
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
            const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child:
                  SingleChildScrollView(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    const Text(
                      'BASKI',
                      style: TextStyle(
                        color:
                            Colors.white,
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    _switchCard(
                      'Otomatik Kırp',
                      autoCrop,
                      (v) {
                        setState(() {
                          autoCrop = v;
                        });
                      },
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    _switchCard(
                      'Otomatik Hizala',
                      autoAlign,
                      (v) {
                        setState(() {
                          autoAlign = v;
                        });
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      width:
                          double.infinity,
                      padding:
                          const EdgeInsets
                              .all(10),
                      decoration:
                          BoxDecoration(
                        color:
                            const Color(
                          0xFF1E293B,
                        ),
                        borderRadius:
                            BorderRadius
                                .circular(
                          14,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${print.photoCount} Adet',
                            style:
                                const TextStyle(
                              color:
                                  Colors.white,
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            print.paper,
                            style:
                                const TextStyle(
                              color:
                                  Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            '${print.photoWidthMm.toStringAsFixed(0)} x ${print.photoHeightMm.toStringAsFixed(0)} mm',
                            style:
                                const TextStyle(
                              color:
                                  Colors.white38,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            SizedBox(
              width:
                  double.infinity,
              height: 44,
              child:
                  ElevatedButton.icon(
                onPressed: () {},
                icon:
                    const Icon(
                  Icons.print,
                  size: 18,
                ),
                label:
                    const Text(
                  'ÖNİZLE',
                ),
                style:
                    ElevatedButton
                        .styleFrom(
                  backgroundColor:
                      const Color(
                    0xFFD4A64A,
                  ),
                  foregroundColor:
                      Colors.black,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius
                            .circular(
                      14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _switchCard(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      height: 48,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
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
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style:
                  const TextStyle(
                color:
                    Colors.white,
                fontSize: 13,
              ),
            ),
          ),
          Transform.scale(
            scale: .85,
            child: Switch(
              value: value,
              onChanged:
                  onChanged,
            ),
          ),
        ],
      ),
    );
  }
}