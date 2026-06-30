enum BatchJobStatus { queued, processing, passed, failed, exported }

class BatchJob {
  final String id;
  final String? customerId;
  final String sourcePath;
  final String? outputPath;
  final String presetCode;
  final BatchJobStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? errorMessage;
  final int stepsCompleted;
  final int totalSteps;

  const BatchJob({
    required this.id,
    required this.sourcePath,
    required this.presetCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.stepsCompleted,
    required this.totalSteps,
    this.customerId,
    this.outputPath,
    this.errorMessage,
  });

  double get progress {
    if (totalSteps == 0) {
      return 0;
    }

    return stepsCompleted / totalSteps;
  }

  BatchJob copyWith({
    String? id,
    String? customerId,
    String? sourcePath,
    String? outputPath,
    String? presetCode,
    BatchJobStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? errorMessage,
    int? stepsCompleted,
    int? totalSteps,
  }) {
    return BatchJob(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      sourcePath: sourcePath ?? this.sourcePath,
      outputPath: outputPath ?? this.outputPath,
      presetCode: presetCode ?? this.presetCode,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      errorMessage: errorMessage ?? this.errorMessage,
      stepsCompleted: stepsCompleted ?? this.stepsCompleted,
      totalSteps: totalSteps ?? this.totalSteps,
    );
  }

  factory BatchJob.fromMap(Map<String, Object?> map) {
    return BatchJob(
      id: map['id'] as String,
      customerId: map['customer_id'] as String?,
      sourcePath: map['source_path'] as String,
      outputPath: map['output_path'] as String?,
      presetCode: map['preset_code'] as String,
      status: BatchJobStatus.values.firstWhere(
        (status) => status.name == map['status'],
        orElse: () => BatchJobStatus.queued,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
      errorMessage: map['error_message'] as String?,
      stepsCompleted: map['steps_completed'] as int,
      totalSteps: map['total_steps'] as int,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'customer_id': customerId,
      'source_path': sourcePath,
      'output_path': outputPath,
      'preset_code': presetCode,
      'status': status.name,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'error_message': errorMessage,
      'steps_completed': stepsCompleted,
      'total_steps': totalSteps,
    };
  }
}
