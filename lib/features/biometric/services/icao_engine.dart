import '../models/face_analysis_result.dart';

class IcaoValidationResult {
  final bool passed;
  final List<String> warnings;
  final double score;

  const IcaoValidationResult({
    required this.passed,
    required this.warnings,
    required this.score,
  });
}

class IcaoEngine {
  const IcaoEngine();

  IcaoValidationResult validate(
    FaceAnalysisResult result,
  ) {
    final warnings = <String>[];
    double score = 100;

    if (!result.faceDetected) {
      return const IcaoValidationResult(
        passed: false,
        warnings: [
          'Yüz algılanamadı.',
        ],
        score: 0,
      );
    }

    // Baş yüksekliği (%70-%80)
    if (result.headRatio < 0.68) {
      warnings.add(
        'Yüz çok küçük görünüyor.',
      );
      score -= 15;
    }

    if (result.headRatio > 0.82) {
      warnings.add(
        'Yüz çok büyük görünüyor.',
      );
      score -= 15;
    }

    // Göz çizgisi (%35-%45)
    if (result.eyeLineRatio < 0.35) {
      warnings.add(
        'Gözler çok yukarıda.',
      );
      score -= 10;
    }

    if (result.eyeLineRatio > 0.45) {
      warnings.add(
        'Gözler çok aşağıda.',
      );
      score -= 10;
    }

    // Çözünürlük
    if (result.resolutionScore < 80) {
      warnings.add(
        'Fotoğraf çözünürlüğü düşük.',
      );
      score -= 10;
    }

    // Arka plan
    if (result.backgroundScore < 80) {
      warnings.add(
        'Arka plan uygun görünmüyor.',
      );
      score -= 10;
    }

    // Merkezleme
    if (result.centeringScore < 80) {
      warnings.add(
        'Yüz merkeze hizalı değil.',
      );
      score -= 10;
    }

    score = score.clamp(
      0,
      100,
    );

    return IcaoValidationResult(
      passed: score >= 80,
      warnings: warnings,
      score: score.toDouble(),
    );
  }
}