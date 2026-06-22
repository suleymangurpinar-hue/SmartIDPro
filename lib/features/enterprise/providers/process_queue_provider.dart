import 'package:flutter/material.dart';

import '../models/process_queue_item.dart';

class ProcessQueueProvider
    extends ChangeNotifier {
  final List<ProcessQueueItem>
      _items = [];

  List<ProcessQueueItem>
      get items =>
          List.unmodifiable(
            _items,
          );

  void add(
    String filename,
  ) {
    _items.insert(
      0,
      ProcessQueueItem(
        name: filename,
        status:
            QueueStatus.processing,
        createdAt:
            DateTime.now(),
      ),
    );

    notifyListeners();
  }

  void clear() {
    _items.clear();

    notifyListeners();
  }
}