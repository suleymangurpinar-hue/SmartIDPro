import '../models/ai_engine_task_result.dart';

class AiBackgroundRequest {
  final String? imagePath;
  final String mode;
  final int colorValue;
  final bool preserveHairDetail;

  const AiBackgroundRequest({
    required this.imagePath,
    required this.mode,
    required this.colorValue,
    this.preserveHairDetail = true,
  });
}

class AiBackgroundEngine {
  Future<AiEngineTaskResult> apply(AiBackgroundRequest request) async {
    final started = DateTime.now();

    await Future<void>.delayed(const Duration(milliseconds: 350));

    return AiEngineTaskResult(
      jobId: 'bg-${started.microsecondsSinceEpoch}',
      engine: 'ai-background',
      status: 'queued',
      elapsed: DateTime.now().difference(started),
      outputPath: request.imagePath,
      metadata: {
        'mode': request.mode,
        'colorValue': request.colorValue,
        'preserveHairDetail': request.preserveHairDetail,
      },
    );
  }
}
