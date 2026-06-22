import 'package:flutter/material.dart';

class ProcessQueuePanel extends StatelessWidget {
  const ProcessQueuePanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: const Color(
            0x22FFFFFF,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          18,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              "PROCESS QUEUE",
              style: TextStyle(
                color: Colors.white,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Expanded(
              child: ListView(
                children: const [
                  _JobTile(
                    "Ahmet_Yilmaz.jpg",
                    "PROCESSING",
                    Color(
                      0xFFD4A64A,
                    ),
                  ),
                  _JobTile(
                    "Ayse_Kaya.jpg",
                    "READY",
                    Color(
                      0xFF34D399,
                    ),
                  ),
                  _JobTile(
                    "Mehmet_Demir.jpg",
                    "EXPORTED",
                    Color(
                      0xFF60A5FA,
                    ),
                  ),
                  _JobTile(
                    "Passport_001.jpg",
                    "QUEUED",
                    Color(
                      0xFF9CA3AF,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JobTile extends StatelessWidget {
  final String title;
  final String status;
  final Color color;

  const _JobTile(
    this.title,
    this.status,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),
      padding:
          const EdgeInsets.all(
        12,
      ),
      decoration: BoxDecoration(
        color:
            const Color(0xFF182232),
        borderRadius:
            BorderRadius.circular(
          14,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape:
                  BoxShape.circle,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              title,
              style:
                  const TextStyle(
                color:
                    Colors.white,
              ),
            ),
          ),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}