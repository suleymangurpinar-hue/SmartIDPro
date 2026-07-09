import '../models/background_result.dart';
import 'ai_background_service.dart';

class MockAiBackgroundService implements AiBackgroundService {
  @override
  Future<BackgroundResult> generate() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    const BackgroundResult(
      selectedItem: null,
      status: BackgroundStatus.preparing,
    );

    await Future<void>.delayed(const Duration(milliseconds: 350));
    const BackgroundResult(
      selectedItem: null,
      status: BackgroundStatus.processing,
    );

    await Future<void>.delayed(const Duration(milliseconds: 450));
    return const BackgroundResult(
      selectedItem: null,
      status: BackgroundStatus.completed,
    );
  }
}
