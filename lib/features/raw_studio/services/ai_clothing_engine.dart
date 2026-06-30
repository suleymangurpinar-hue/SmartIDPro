import '../models/ai_engine_task_result.dart';

class AiClothingRequest {
  final String? imagePath;
  final String category;
  final String style;
  final bool keepOriginalNeckline;

  const AiClothingRequest({
    required this.imagePath,
    required this.category,
    required this.style,
    this.keepOriginalNeckline = true,
  });
}

class AiClothingEngine {
  Future<AiEngineTaskResult> apply(AiClothingRequest request) async {
    final started = DateTime.now();

    await Future<void>.delayed(const Duration(milliseconds: 390));

    return AiEngineTaskResult(
      jobId: 'clothing-${started.microsecondsSinceEpoch}',
      engine: 'ai-clothing',
      status: 'queued',
      elapsed: DateTime.now().difference(started),
      outputPath: request.imagePath,
      metadata: {
        'category': request.category,
        'style': request.style,
        'keepOriginalNeckline': request.keepOriginalNeckline,
      },
    );
  }
}
