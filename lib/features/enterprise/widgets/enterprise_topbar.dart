import 'package:flutter/material.dart';

import 'import_photo_button.dart';

class EnterpriseTopBar extends StatelessWidget {
  const EnterpriseTopBar({
    super.key,
    this.title = 'ICAO PASS',
    this.score = '98%',
    this.showImportButton = true,
    this.statusLabels = const [
      'FACE',
      'EYES',
      'HEAD',
      'BACKGROUND',
    ],
    this.userLabel,
  });

  final String title;
  final String? score;
  final bool showImportButton;
  final List<String> statusLabels;
  final String? userLabel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 1200;

        return Container(
          height: 82,
          decoration: BoxDecoration(
            color: const Color(0xFF131C2B),
            borderRadius: BorderRadius.circular(24),
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
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF34D399),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                if (score != null)
                  Text(
                    score!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                if (score != null)
                  const SizedBox(width: 20),

                if (showImportButton)
                  const ImportPhotoButton(),

                const SizedBox(width: 20),

                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection:
                        Axis.horizontal,
                    reverse: true,
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end,
                      children: [
                        ...statusLabels.map(
                          (label) =>
                              _Status(label),
                        ),

                        if (userLabel != null)
                          Padding(
                            padding:
                                const EdgeInsets.only(
                              left: 18,
                            ),
                            child: ConstrainedBox(
                              constraints:
                                  BoxConstraints(
                                maxWidth:
                                    compact
                                        ? 100
                                        : 160,
                              ),
                              child: Text(
                                userLabel!,
                                overflow:
                                    TextOverflow
                                        .ellipsis,
                                style:
                                    const TextStyle(
                                  color:
                                      Colors
                                          .white54,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
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
        );
      },
    );
  }
}

class _Status extends StatelessWidget {
  final String title;

  const _Status(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(
        left: 18,
      ),
      child: Row(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle,
            size: 18,
            color: Color(0xFF34D399),
          ),
          const SizedBox(width: 6),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}