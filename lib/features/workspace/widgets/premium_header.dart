import 'package:flutter/material.dart';

class PremiumHeader extends StatelessWidget {
  const PremiumHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      margin: const EdgeInsets.all(18),
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF8D6A20), width: 0.6),
      ),
      child: Row(
        children: [
          const Text(
            "SMART ID PRO",
            style: TextStyle(
              color: Color(0xFFD4AF37),
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(width: 12),

          const Text(
            "ENTERPRISE",
            style: TextStyle(color: Colors.white54, letterSpacing: 3),
          ),

          const Spacer(),

          _action("License"),
          _action("Cloud"),
          _action("Account"),
        ],
      ),
    );
  }

  Widget _action(String title) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF8D6A20), width: 0.5),
      ),
      child: Text(title),
    );
  }
}
