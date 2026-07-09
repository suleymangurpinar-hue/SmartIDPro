class WorkspaceImage {
  final String path;
  final String fileName;
  final int? width;
  final int? height;

  const WorkspaceImage({
    required this.path,
    required this.fileName,
    this.width,
    this.height,
  });

  WorkspaceImage copyWith({
    String? path,
    String? fileName,
    int? width,
    int? height,
  }) {
    return WorkspaceImage(
      path: path ?? this.path,
      fileName: fileName ?? this.fileName,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
}
