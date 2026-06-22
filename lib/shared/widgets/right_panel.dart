import 'package:flutter/material.dart';

class RightPanel extends StatelessWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      decoration: BoxDecoration(
        color: const Color(0xFF0E1420),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFF1D2A40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AI STUDIO',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 20),
            _item('AI Background'),
            _item('Face Retouch'),
            _item('Passport Rules'),
            _item('Biometric Check'),
            _item('Print Layout'),
            const Spacer(),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2F6BFF),
                    Color(0xFF5F96FF),
                  ],
                ),
              ),
              child: const Center(
                child: Text(
                  'PROCESS PHOTO',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget _item(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151F31),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(title),
    );
  }
}