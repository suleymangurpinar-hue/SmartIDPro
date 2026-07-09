import 'dart:math' as math;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enterprise/providers/workspace_provider.dart';
import '../providers/print_studio_provider.dart';

class PreviewCanvas extends StatelessWidget {
  const PreviewCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    final print = context.watch<PrintStudioProvider>();

    final workspace = context.watch<WorkspaceProvider>();

    final imagePath = workspace.imagePath;
    final layout = print.photoLayout;

    if (imagePath == null) {
      return _PreviewFrame(
        child: _PaperSurface(
          paperWidthMm: layout.paperWidthMm,
          paperHeightMm: layout.paperHeightMm,
          child: const Center(
            child: Text(
              'Fotoğraf Seçilmedi',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }

    return _PreviewFrame(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final scale = math.min(
            constraints.maxWidth / layout.paperWidthMm,
            constraints.maxHeight / layout.paperHeightMm,
          );
          final paperWidth = layout.paperWidthMm * scale;
          final paperHeight = layout.paperHeightMm * scale;

          return Center(
            child: _PaperSurface(
              paperWidthMm: layout.paperWidthMm,
              paperHeightMm: layout.paperHeightMm,
              child: SizedBox(
                width: paperWidth,
                height: paperHeight,
                child: Stack(
                  children: [
                    for (final placement in layout.placements)
                      Positioned(
                        left: placement.xMm * scale,
                        top: placement.yMm * scale,
                        width: placement.widthMm * scale,
                        height: placement.heightMm * scale,
                        child: _PhotoPrint(
                          imagePath: imagePath,
                          rotatePhoto: placement.rotatePhoto,
                          photoScale: workspace.scale,
                          photoOffset: workspace.offset,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PreviewFrame extends StatelessWidget {
  const _PreviewFrame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF050B16),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}

class _PaperSurface extends StatelessWidget {
  const _PaperSurface({
    required this.paperWidthMm,
    required this.paperHeightMm,
    required this.child,
  });

  final double paperWidthMm;
  final double paperHeightMm;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: paperWidthMm / paperHeightMm,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, .28),
              blurRadius: 18,
              offset: Offset(0, 10),
            ),
          ],
          border: Border.all(color: Colors.black12, width: .5),
        ),
        child: child,
      ),
    );
  }
}

class _PhotoPrint extends StatelessWidget {
  const _PhotoPrint({
    required this.imagePath,
    required this.rotatePhoto,
    required this.photoScale,
    required this.photoOffset,
  });

  final String imagePath;
  final bool rotatePhoto;
  final double photoScale;
  final Offset photoOffset;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: .5),
      ),
      child: ClipRect(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final image = Transform.translate(
              offset: photoOffset,
              child: Transform.scale(
                scale: photoScale,
                alignment: Alignment.center,
                child: Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            );

            if (!rotatePhoto) {
              return SizedBox.expand(child: image);
            }

            return Center(
              child: Transform.rotate(
                angle: math.pi / 2,
                child: SizedBox(
                  width: constraints.maxHeight,
                  height: constraints.maxWidth,
                  child: image,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
