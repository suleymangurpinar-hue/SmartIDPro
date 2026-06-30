import 'package:flutter/material.dart';

import '../models/document_job.dart';

class JobHistoryProvider extends ChangeNotifier {
  final List<DocumentJob> _jobs = [];

  List<DocumentJob> get jobs => _jobs.reversed.toList();

  void addJob(DocumentJob job) {
    _jobs.add(job);
    notifyListeners();
  }

  void clear() {
    _jobs.clear();
    notifyListeners();
  }
}
