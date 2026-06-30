import '../models/ai_engine_task_result.dart';

class AiRetouchRequest {
  final String? imagePath;
  final String preset;
  final double skinSmoothing;
  final double blemishRemoval;
  final double underEyeCorrection;
  final double shineRemoval;

  const AiRetouchRequest({
    required this.imagePath,
    required this.preset,
    required this.skinSmoothing,
    required this.blemishRemoval,
    required this.underEyeCorrection,
    required this.shineRemoval,
  });
}

class AiRetouchEngine {
  Future<AiEngineTaskResult> apply(AiRetouchRequest request) async {
    final started = DateTime.now();

    await Future<void>.delayed(const Duration(milliseconds: 420));

    return AiEngineTaskResult(
      jobId: 'retouch-${started.microsecondsSinceEpoch}',
      engine: 'ai-retouch',
      status: 'queued',
      elapsed: DateTime.now().difference(started),
      outputPath: request.imagePath,
      metadata: {
        'preset': request.preset,
        'skinSmoothing': request.skinSmoothing,
        'blemishRemoval': request.blemishRemoval,
        'underEyeCorrection': request.underEyeCorrection,
        'shineRemoval': request.shineRemoval,
      },
    );
  }
}
