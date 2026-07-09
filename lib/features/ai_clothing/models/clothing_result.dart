import 'clothing_item.dart';

enum ClothingStatus { idle, preparing, processing, completed, failed }

class ClothingResult {
  final ClothingItem? selectedItem;
  final ClothingStatus status;

  const ClothingResult({required this.selectedItem, required this.status});
}
