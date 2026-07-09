import '../models/clothing_result.dart';

abstract class AiClothingService {
  Future<ClothingResult> generate();
}
