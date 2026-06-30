class DocumentJob {
  final String imagePath;

  final DateTime createdAt;

  final String preset;

  final bool icaoPassed;

  const DocumentJob({
    required this.imagePath,
    required this.createdAt,
    required this.preset,
    required this.icaoPassed,
  });
}
