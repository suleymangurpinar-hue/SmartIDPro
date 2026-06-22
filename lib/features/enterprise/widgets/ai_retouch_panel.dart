import 'package:flutter/material.dart';

class AiRetouchPanel extends StatefulWidget {
  const AiRetouchPanel({
    super.key,
  });

  @override
  State<AiRetouchPanel> createState() =>
      _AiRetouchPanelState();
}

class _AiRetouchPanelState
    extends State<AiRetouchPanel> {
  int selectedPreset = 3;

  double skin = 70;
  double blemish = 65;
  double underEye = 60;
  double teeth = 40;
  double shine = 50;
  double contour = 55;
  double eyeEnhance = 60;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(
            6,
            (index) {
              final titles = [
                "OFF",
                "NATURAL",
                "STUDIO",
                "PREMIUM",
                "BEAUTY",
                "ADVANCED",
              ];

              final active =
                  selectedPreset ==
                      index;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPreset =
                          index;
                    });
                  },
                  child: Container(
                    height: 38,
                    margin:
                        const EdgeInsets.only(
                      right: 4,
                    ),
                    decoration:
                        BoxDecoration(
                      color: active
                          ? const Color(
                              0xFFD4A64A,
                            )
                          : const Color(
                              0xFF1E293B,
                            ),
                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        titles[index],
                        textAlign:
                            TextAlign.center,
                        style:
                            TextStyle(
                          fontSize: 9,
                          color: active
                              ? Colors.black
                              : Colors.white70,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(
          height: 16,
        ),

        _slider(
          "Skin Smoothing",
          skin,
          (v) => setState(
            () => skin = v,
          ),
        ),

        _slider(
          "Blemish Removal",
          blemish,
          (v) => setState(
            () => blemish = v,
          ),
        ),

        _slider(
          "Under Eye",
          underEye,
          (v) => setState(
            () => underEye = v,
          ),
        ),

        _slider(
          "Teeth Whitening",
          teeth,
          (v) => setState(
            () => teeth = v,
          ),
        ),

        _slider(
          "Shine Removal",
          shine,
          (v) => setState(
            () => shine = v,
          ),
        ),

        _slider(
          "Face Contour",
          contour,
          (v) => setState(
            () => contour = v,
          ),
        ),

        _slider(
          "Eye Enhancement",
          eyeEnhance,
          (v) => setState(
            () => eyeEnhance = v,
          ),
        ),
      ],
    );
  }

  Widget _slider(
    String title,
    double value,
    Function(double) onChanged,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style:
                      const TextStyle(
                    color:
                        Colors.white70,
                  ),
                ),
              ),
              Text(
                value
                    .round()
                    .toString(),
              ),
            ],
          ),
          Slider(
            value: value,
            max: 100,
            activeColor:
                const Color(
              0xFFD4A64A,
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}