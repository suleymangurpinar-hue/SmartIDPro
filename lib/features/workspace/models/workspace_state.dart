import 'dart:ui';

import 'workspace_image.dart';

class WorkspaceState {
  final WorkspaceImage? originalImage;
  final WorkspaceImage? workingImage;
  final WorkspaceImage? previewImage;
  final int? imageWidth;
  final int? imageHeight;
  final String? fileName;
  final double zoom;
  final double rotation;
  final Rect? cropRect;
  final List<WorkspaceState> history;

  const WorkspaceState({
    this.originalImage,
    this.workingImage,
    this.previewImage,
    this.imageWidth,
    this.imageHeight,
    this.fileName,
    this.zoom = 1.0,
    this.rotation = 0.0,
    this.cropRect,
    this.history = const [],
  });

  WorkspaceState copyWith({
    WorkspaceImage? originalImage,
    WorkspaceImage? workingImage,
    WorkspaceImage? previewImage,
    int? imageWidth,
    int? imageHeight,
    String? fileName,
    double? zoom,
    double? rotation,
    Rect? cropRect,
    List<WorkspaceState>? history,
    bool clearImages = false,
    bool clearCropRect = false,
  }) {
    return WorkspaceState(
      originalImage: clearImages ? null : originalImage ?? this.originalImage,
      workingImage: clearImages ? null : workingImage ?? this.workingImage,
      previewImage: clearImages ? null : previewImage ?? this.previewImage,
      imageWidth: clearImages ? null : imageWidth ?? this.imageWidth,
      imageHeight: clearImages ? null : imageHeight ?? this.imageHeight,
      fileName: clearImages ? null : fileName ?? this.fileName,
      zoom: zoom ?? this.zoom,
      rotation: rotation ?? this.rotation,
      cropRect: clearCropRect ? null : cropRect ?? this.cropRect,
      history: history ?? this.history,
    );
  }

  static const empty = WorkspaceState();
}
