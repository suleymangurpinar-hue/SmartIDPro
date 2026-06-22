import 'package:flutter/material.dart';

import 'import_photo_button.dart';

class EnterpriseTopBar extends StatelessWidget {
  const EnterpriseTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      decoration: BoxDecoration(
        color: const Color(0xFF131C2B),
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: const Color.fromRGBO(
            255,
            255,
            255,
            .06,
          ),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Row(
          children: [
            const Text(
              "ICAO PASS",
              style: TextStyle(
                color: Color(
                  0xFF34D399,
                ),
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              width: 16,
            ),

            const Text(
              "98%",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              width: 24,
            ),

            const ImportPhotoButton(),

            const Spacer(),

            const _Status(
              "FACE",
            ),

            const _Status(
              "EYES",
            ),

            const _Status(
              "HEAD",
            ),

            const _Status(
              "BACKGROUND",
            ),
          ],
        ),
      ),
    );
  }
}

class _Status extends StatelessWidget {
  final String title;

  const _Status(
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(
        left: 18,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            size: 18,
            color: Color(
              0xFF34D399,
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}