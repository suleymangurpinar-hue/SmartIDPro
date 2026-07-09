import 'background_item.dart';

enum BackgroundStatus { idle, preparing, processing, completed, failed }

class BackgroundResult {
  final BackgroundItem? selectedItem;
  final BackgroundStatus status;

  const BackgroundResult({required this.selectedItem, required this.status});
}
