import '../models/background_result.dart';

abstract class AiBackgroundService {
  Future<BackgroundResult> generate();
}
