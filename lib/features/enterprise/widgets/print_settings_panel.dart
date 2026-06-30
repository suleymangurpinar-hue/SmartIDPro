import 'package:flutter/material.dart';

class PrintSettingsPanel extends StatefulWidget {
  const PrintSettingsPanel({super.key});

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact =
            constraints.maxWidth < 180;

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
            padding:
                const EdgeInsets.all(18),
            child:
                SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PRINT SETTINGS',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight:
                          FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  _settingTile(
                    'Auto Crop',
                    autoCrop,
                    compact,
                    (v) {
                      setState(() {
                        autoCrop = v;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _settingTile(
                    'Auto Align',
                    autoAlign,
                    compact,
                    (v) {
                      setState(() {
                        autoAlign = v;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width:
                        double.infinity,
                    padding:
                        const EdgeInsets
                            .all(12),
                    decoration:
                        BoxDecoration(
                      color:
                          const Color(
                        0xFF1E293B,
                      ),
                      borderRadius:
                          BorderRadius
                              .circular(
                        12,
                      ),
                    ),
                    child: const Text(
                      '8 Photos • 10x15',
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        color:
                            Colors.white70,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width:
                        double.infinity,
                    height: 42,
                    child:
                        ElevatedButton
                            .icon(
                      onPressed: () {},
                      icon:
                          const Icon(
                        Icons.print,
                        size: 18,
                      ),
                      label:
                          const Text(
                        'PRINT PREVIEW',
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
                            12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _settingTile(
    String title,
    bool value,
    bool compact,
    ValueChanged<bool>
        onChanged,
  ) {
    if (compact) {
      return Container(
        width: double.infinity,
        padding:
            const EdgeInsets.all(12),
        decoration:
            BoxDecoration(
          color:
              const Color(
            0xFF1E293B,
          ),
          borderRadius:
              BorderRadius.circular(
            12,
          ),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
                  const TextStyle(
                color:
                    Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment:
                  Alignment.centerRight,
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

    return Container(
      height: 42,
      decoration:
          BoxDecoration(
        color:
            const Color(
          0xFF1E293B,
        ),
        borderRadius:
            BorderRadius.circular(
          12,
        ),
      ),
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
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
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged:
                onChanged,
          ),
        ],
      ),
    );
  }
}