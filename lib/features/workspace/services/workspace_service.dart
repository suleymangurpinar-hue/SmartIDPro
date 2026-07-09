import 'dart:io';
import 'dart:ui' as ui;

import 'package:path/path.dart' as path;

import '../models/workspace_image.dart';
import '../models/workspace_state.dart';

class WorkspaceService {
  WorkspaceState _state = WorkspaceState.empty;

  WorkspaceState get state => _state;

  Future<WorkspaceImage> buildImage(String imagePath) async {
    final size = await _readImageSize(imagePath);

    return WorkspaceImage(
      path: imagePath,
      fileName: path.basename(imagePath),
      width: size?.width,
      height: size?.height,
    );
  }

  void save(WorkspaceState state) {
    _state = state;
  }

  Future<_ImageSize?> _readImageSize(String imagePath) async {
    try {
      final bytes = await File(imagePath).readAsBytes();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final image = frame.image;
      final size = _ImageSize(image.width, image.height);
      image.dispose();
      codec.dispose();
      return size;
    } catch (_) {
      return null;
    }
  }
}

class _ImageSize {
  final int width;
  final int height;

  const _ImageSize(this.width, this.height);
}
