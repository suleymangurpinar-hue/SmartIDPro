import '../models/face_analysis_result.dart';
import 'auto_crop_service.dart';
import 'face_analysis_service.dart';
import 'icao_engine.dart';

class BiometricProcessResult {
  final FaceAnalysisResult analysis;
  final IcaoValidationResult icao;
  final AutoCropResult crop;

  const BiometricProcessResult({
    required this.analysis,
    required this.icao,
    required this.crop,
  });
}

class BiometricEngine {
  final FaceAnalysisService _analysisService =
      FaceAnalysisService();

  final IcaoEngine _icaoEngine =
      const IcaoEngine();

  final AutoCropService _cropService =
      const AutoCropService();

  Future<BiometricProcessResult?> analyze(
    String imagePath,
    double imageWidth,
    double imageHeight,
  ) async {
    final analysis =
        await _analysisService.analyze(
      imagePath,
    );

    if (!analysis.faceDetected) {
      return null;
    }

    final icao =
        _icaoEngine.validate(
      analysis,
    );

    final crop =
        _cropService.calculate(
      analysis,
      imageWidth: imageWidth,
      imageHeight: imageHeight,
    );

    return BiometricProcessResult(
      analysis: analysis,
      icao: icao,
      crop: crop,
    );
  }
}