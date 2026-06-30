class AiEngineTaskResult {
  final String jobId;
  final String engine;
  final String status;
  final String? outputPath;
  final Duration elapsed;
  final Map<String, Object?> metadata;

  const AiEngineTaskResult({
    required this.jobId,
    required this.engine,
    required this.status,
    required this.elapsed,
    this.outputPath,
    this.metadata = const {},
  });
}
