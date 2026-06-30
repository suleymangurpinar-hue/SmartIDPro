import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enterprise/providers/workspace_provider.dart';
import '../services/print_preview_service.dart';

class PreviewCanvas extends StatelessWidget {
  final int count;

  const PreviewCanvas({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final workspace =
        context.watch<WorkspaceProvider>();

    final imagePath =
        workspace.imagePath;

    final cross =
        PrintPreviewService
            .calculateCrossCount(
      count,
    );

    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius:
              BorderRadius.circular(14),
          border: Border.all(
            color:
                Colors.grey.shade400,
          ),
          boxShadow: const [
            BoxShadow(
              color:
                  Color(0x22000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.all(
            14,
          ),
          child: GridView.count(
            physics:
                const NeverScrollableScrollPhysics(),
            crossAxisCount:
                cross,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(
              count,
              (index) {
                return Container(
                  decoration:
                      BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(
                      6,
                    ),
                    border:
                        Border.all(
                      color:
                          Colors
                              .grey
                              .shade400,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child:
                            imagePath ==
                                    null
                                ? Container(
                                    color:
                                        Colors
                                            .grey
                                            .shade200,
                                    child:
                                        const Icon(
                                      Icons
                                          .person,
                                      color:
                                          Colors
                                              .grey,
                                      size:
                                          34,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(
                                      5,
                                    ),
                                    child:
                                        Image.file(
                                      File(
                                        imagePath,
                                      ),
                                      fit:
                                          BoxFit
                                              .cover,
                                    ),
                                  ),
                      ),

                      Positioned.fill(
                        child:
                            IgnorePointer(
                          child:
                              CustomPaint(
                            painter:
                                _CutGuidePainter(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CutGuidePainter
    extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..color =
          const Color(
            0x22000000,
          )
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(
        size.width / 2,
        0,
      ),
      Offset(
        size.width / 2,
        size.height,
      ),
      paint,
    );

    canvas.drawLine(
      Offset(
        0,
        size.height / 2,
      ),
      Offset(
        size.width,
        size.height / 2,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}