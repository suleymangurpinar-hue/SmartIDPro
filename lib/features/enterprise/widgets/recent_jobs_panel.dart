import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/job_history_provider.dart';

class RecentJobsPanel
    extends StatelessWidget {
  const RecentJobsPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<JobHistoryProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        return Container(
          decoration: BoxDecoration(
            color:
                const Color(0xFF111827),
            borderRadius:
                BorderRadius.circular(
              24,
            ),
            border: Border.all(
              color:
                  const Color(
                0x22FFFFFF,
              ),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.all(
              18,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "RECENT JOBS",
                  style: TextStyle(
                    color:
                        Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        provider.jobs.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      final job =
                          provider.jobs[
                              index];

                      return Container(
                        margin:
                            const EdgeInsets.only(
                          bottom: 10,
                        ),
                        padding:
                            const EdgeInsets.all(
                          12,
                        ),
                        decoration:
                            BoxDecoration(
                          color:
                              const Color(
                            0xFF182232,
                          ),
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            Text(
                              job.preset,
                              style:
                                  const TextStyle(
                                color:
                                    Colors.white,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              job.createdAt
                                  .toString(),
                              style:
                                  const TextStyle(
                                color:
                                    Colors.white54,
                                fontSize:
                                    11,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}