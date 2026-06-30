enum QueueStatus { queued, processing, ready, exported }

class ProcessQueueItem {
  final String name;

  final QueueStatus status;

  final DateTime createdAt;

  const ProcessQueueItem({
    required this.name,
    required this.status,
    required this.createdAt,
  });
}
