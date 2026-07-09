import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/face_mesh_model.dart';
import '../providers/workspace_provider.dart';
import 'icao_crop_overlay.dart';
import 'live_face_mesh_overlay.dart';

class AiScanWorkspace extends StatelessWidget {
  final String? imagePath;

  const AiScanWorkspace({
    super.key,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final mesh = FaceMeshModel.demo();

    return Consumer<WorkspaceProvider>(
      builder: (context, workspace, child) {
        final safeScale = workspace.scale.clamp(
          1.0,
          1.35,
        );

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF07111D),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withValues(alpha: .06),
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(0, -.18),
                        radius: 1.1,
                        colors: [
                          Color(0xFF163047),
                          Color(0xFF07111D),
                          Color(0xFF030712),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _HudGridPainter(),
                  ),
                ),
              ),

              const Positioned.fill(
                child: IgnorePointer(
                  child: IcaoCropOverlay(),
                ),
              ),

              const Positioned(
                top: 18,
                left: 24,
                child: Text(
                  'SMART ID PRO',
                  style: TextStyle(
                    color: Color(0xFF65B9FF),
                    letterSpacing: 4,
                    fontSize: 11,
                  ),
                ),
              ),

              const Positioned(
                top: 14,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'BIOMETRIC ANALYSIS',
                    style: TextStyle(
                      color: Color(0xFF89D0FF),
                      letterSpacing: 5,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),

              const Positioned(
                left: 24,
                bottom: 24,
                child: _HudTag(
                  'FACE DETECTED',
                ),
              ),

              const Positioned(
                right: 24,
                bottom: 24,
                child: _HudTag(
                  'ICAO READY',
                ),
              ),

              if (imagePath != null)
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(48),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return ClipRect(
                          child: Transform.translate(
                            offset: workspace.offset,
                            child: Transform.scale(
                              alignment: Alignment.center,
                              scale: safeScale,
                              child: Image.file(
                                File(imagePath!),
                                fit: BoxFit.contain,
                                width: constraints.maxWidth,
                                height: constraints.maxHeight,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

              if (imagePath != null)
                Positioned.fill(
                  child: IgnorePointer(
                    child: LiveFaceMeshOverlay(
                      mesh: mesh,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _HudTag extends StatelessWidget {
  final String title;

  const _HudTag(
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xCC0B1320),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF45A9FF),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF65B9FF),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _HudGridPainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final grid = Paint()
      ..color = const Color(0x111F8FFF)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        grid,
      );
    }

    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        grid,
      );
    }

    final radar = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0x111F8FFF);

    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    for (int i = 1; i <= 5; i++) {
      canvas.drawCircle(
        center,
        i * 120,
        radar,
      );
    }
  }

  @override
  bool shouldRepaint(
    CustomPainter oldDelegate,
  ) {
    return false;
  }
}