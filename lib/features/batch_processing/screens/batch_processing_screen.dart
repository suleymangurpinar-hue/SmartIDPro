import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enterprise/providers/workspace_provider.dart';
import '../models/batch_job.dart';
import '../providers/batch_processing_provider.dart';

class BatchProcessingScreen extends StatelessWidget {
  const BatchProcessingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BatchProcessingProvider>(
      builder: (context, provider, child) {
        return Row(
          children: [
            Expanded(flex: 4, child: _BatchCommandPanel(provider: provider)),
            const SizedBox(width: 18),
            Expanded(flex: 7, child: _BatchQueuePanel(provider: provider)),
          ],
        );
      },
    );
  }
}

class _BatchCommandPanel extends StatelessWidget {
  const _BatchCommandPanel({required this.provider});

  final BatchProcessingProvider provider;

  @override
  Widget build(BuildContext context) {
    final imagePath = context.watch<WorkspaceProvider>().imagePath;

    return Container(
      decoration: _panelDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BATCH PROCESSING',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 18),
            _StatCard(
              label: 'Queued',
              value: provider.queuedCount.toString(),
              color: const Color(0xFFD4A64A),
            ),
            _StatCard(
              label: 'Completed',
              value: provider.completedCount.toString(),
              color: const Color(0xFF34D399),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => provider.addWorkspaceJob(imagePath),
                icon: const Icon(Icons.playlist_add),
                label: const Text('ADD JOB'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: provider.running || provider.queuedCount == 0
                    ? null
                    : provider.runQueue,
                icon: const Icon(Icons.play_arrow),
                label: const Text('RUN QUEUE'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: provider.clearCompleted,
                icon: const Icon(Icons.cleaning_services_outlined),
                label: const Text('CLEAR DONE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BatchQueuePanel extends StatelessWidget {
  const _BatchQueuePanel({required this.provider});

  final BatchProcessingProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _panelDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'QUEUE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: provider.loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: provider.jobs.length,
                      itemBuilder: (context, index) {
                        return _BatchJobTile(job: provider.jobs[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BatchJobTile extends StatelessWidget {
  const _BatchJobTile({required this.job});

  final BatchJob job;

  @override
  Widget build(BuildContext context) {
    final color = switch (job.status) {
      BatchJobStatus.queued => const Color(0xFF9CA3AF),
      BatchJobStatus.processing => const Color(0xFFD4A64A),
      BatchJobStatus.passed => const Color(0xFF34D399),
      BatchJobStatus.failed => const Color(0xFFF87171),
      BatchJobStatus.exported => const Color(0xFF60A5FA),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF182232),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  job.sourcePath,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                job.status.name.toUpperCase(),
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: job.progress,
              minHeight: 8,
              color: color,
              backgroundColor: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF182232),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(color: Colors.white70)),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _panelDecoration() {
  return BoxDecoration(
    color: const Color(0xFF111827),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: const Color.fromRGBO(255, 255, 255, .06)),
  );
}
