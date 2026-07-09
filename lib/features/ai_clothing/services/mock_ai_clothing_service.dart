import '../models/clothing_result.dart';
import 'ai_clothing_service.dart';

class MockAiClothingService implements AiClothingService {
  @override
  Future<ClothingResult> generate() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    const ClothingResult(selectedItem: null, status: ClothingStatus.preparing);

    await Future<void>.delayed(const Duration(milliseconds: 350));
    const ClothingResult(selectedItem: null, status: ClothingStatus.processing);

    await Future<void>.delayed(const Duration(milliseconds: 450));
    return const ClothingResult(
      selectedItem: null,
      status: ClothingStatus.completed,
    );
  }
}
