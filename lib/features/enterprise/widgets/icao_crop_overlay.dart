import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../workspace/providers/workspace_provider.dart';

class IcaoCropOverlay extends StatelessWidget {
  const IcaoCropOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkspaceProvider>(
      builder: (context, workspace, child) {
        if (!workspace.hasImage ||
            workspace.imagePath == null) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: const Color(
                  0xFF1E3557,
                ),
              ),
            ),
            child: const Center(
              child: Text(
                'Fotoğraf İçe Aktarın',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 18,
                ),
              ),
            ),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            return ClipRRect(
              borderRadius:
                  BorderRadius.circular(28),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: const Color(
                      0xFF06101F,
                    ),
                  ),
                  InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 3,
                    scaleEnabled: true,
                    panEnabled: true,
                    onInteractionUpdate: (d) {
                      workspace.setScale(
                        d.scale,
                      );
                    },
                    child: Transform.translate(
                      offset:
                          workspace.offset,
                      child: Transform.scale(
                        scale:
                            workspace.scale,
                        child: Image.file(
                          File(
                            workspace
                                .imagePath!,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  IgnorePointer(
                    child: CustomPaint(
                      painter:
                          _IcaoPainter(),
                      size: Size.infinite,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _IcaoPainter
    extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final dark =
        Paint()
          ..color =
              Colors.black54;

    final rect = Rect.fromCenter(
      center: Offset(
        size.width / 2,
        size.height / 2,
      ),
      width: size.width * 0.48,
      height: size.height * 0.72,
    );

    final path =
        Path()
          ..addRect(
            Rect.fromLTWH(
              0,
              0,
              size.width,
              size.height,
            ),
          )
          ..addRRect(
            RRect.fromRectAndRadius(
              rect,
              const Radius.circular(
                22,
              ),
            ),
          )
          ..fillType =
              PathFillType.evenOdd;

    canvas.drawPath(
      path,
      dark,
    );

    final border =
        Paint()
          ..color =
              const Color(
                0xFFD8B05C,
              )
          ..strokeWidth = 2
          ..style =
              PaintingStyle.stroke;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect,
        const Radius.circular(
          22,
        ),
      ),
      border,
    );

    final line =
        Paint()
          ..color =
              const Color(
                0x55D8B05C,
              )
          ..strokeWidth = 1;

    canvas.drawLine(
      Offset(
        rect.left,
        rect.center.dy,
      ),
      Offset(
        rect.right,
        rect.center.dy,
      ),
      line,
    );

    canvas.drawLine(
      Offset(
        rect.center.dx,
        rect.top,
      ),
      Offset(
        rect.center.dx,
        rect.bottom,
      ),
      line,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}