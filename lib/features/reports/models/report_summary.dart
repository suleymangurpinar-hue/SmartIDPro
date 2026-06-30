class ReportSummary {
  final String id;
  final String title;
  final String periodLabel;
  final int totalCustomers;
  final int totalJobs;
  final int passedJobs;
  final int failedJobs;
  final DateTime createdAt;

  const ReportSummary({
    required this.id,
    required this.title,
    required this.periodLabel,
    required this.totalCustomers,
    required this.totalJobs,
    required this.passedJobs,
    required this.failedJobs,
    required this.createdAt,
  });

  double get passRate {
    if (totalJobs == 0) {
      return 0;
    }

    return passedJobs / totalJobs;
  }

  factory ReportSummary.fromMap(Map<String, Object?> map) {
    return ReportSummary(
      id: map['id'] as String,
      title: map['title'] as String,
      periodLabel: map['period_label'] as String,
      totalCustomers: map['total_customers'] as int,
      totalJobs: map['total_jobs'] as int,
      passedJobs: map['passed_jobs'] as int,
      failedJobs: map['failed_jobs'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'period_label': periodLabel,
      'total_customers': totalCustomers,
      'total_jobs': totalJobs,
      'passed_jobs': passedJobs,
      'failed_jobs': failedJobs,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }
}
