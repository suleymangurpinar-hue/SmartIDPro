import 'package:flutter/material.dart';

import '../models/batch_job.dart';
import '../repositories/batch_repository.dart';

class BatchProcessingProvider extends ChangeNotifier {
  BatchProcessingProvider({BatchRepository? repository})
    : _repository = repository ?? BatchRepository();

  final BatchRepository _repository;

  final List<BatchJob> _jobs = [];
  bool _loading = false;
  bool _running = false;

  List<BatchJob> get jobs => List.unmodifiable(_jobs);

  bool get loading => _loading;

  bool get running => _running;

  int get queuedCount =>
      _jobs.where((job) => job.status == BatchJobStatus.queued).length;

  int get completedCount => _jobs
      .where(
        (job) =>
            job.status == BatchJobStatus.passed ||
            job.status == BatchJobStatus.exported,
      )
      .length;

  Future<void> load() async {
    _loading = true;
    notifyListeners();

    final result = await _repository.all();
    _jobs
      ..clear()
      ..addAll(result);

    _loading = false;
    notifyListeners();
  }

  Future<void> addWorkspaceJob(String? imagePath) async {
    final now = DateTime.now();
    final source = imagePath ?? 'batch/input-${now.millisecondsSinceEpoch}.jpg';
    final job = BatchJob(
      id: 'batch-${now.microsecondsSinceEpoch}',
      sourcePath: source,
      presetCode: 'TR-passport-biometric',
      status: BatchJobStatus.queued,
      createdAt: now,
      updatedAt: now,
      stepsCompleted: 0,
      totalSteps: 4,
    );

    await _repository.upsert(job);
    await load();
  }

  Future<void> runQueue() async {
    if (_running) {
      return;
    }

    _running = true;
    notifyListeners();

    final queue = _jobs
        .where((job) => job.status == BatchJobStatus.queued)
        .toList(growable: false);

    for (final job in queue) {
      var current = job.copyWith(
        status: BatchJobStatus.processing,
        updatedAt: DateTime.now(),
      );
      await _repository.upsert(current);
      await load();

      for (var step = 1; step <= current.totalSteps; step++) {
        await Future<void>.delayed(const Duration(milliseconds: 180));
        current = current.copyWith(
          stepsCompleted: step,
          updatedAt: DateTime.now(),
        );
        await _repository.upsert(current);
        await load();
      }

      current = current.copyWith(
        status: BatchJobStatus.passed,
        outputPath: '${current.sourcePath}.processed.png',
        updatedAt: DateTime.now(),
      );
      await _repository.upsert(current);
      await load();
    }

    _running = false;
    notifyListeners();
  }

  Future<void> clearCompleted() async {
    await _repository.clearCompleted();
    await load();
  }
}
