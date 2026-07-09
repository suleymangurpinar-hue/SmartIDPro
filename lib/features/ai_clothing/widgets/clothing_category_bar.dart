import 'package:flutter/material.dart';

class ClothingCategoryBar extends StatelessWidget {
  const ClothingCategoryBar({
    super.key,
    required this.currentGender,
    required this.onGenderChanged,
  });

  final String currentGender;
  final ValueChanged<String> onGenderChanged;

  @override
  Widget build(BuildContext context) {
    final male = currentGender == 'male';

    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                onGenderChanged('male');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: male ? const Color(0xFFD4A64A) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Male',
                    style: TextStyle(
                      color: male ? Colors.black : Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                onGenderChanged('female');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: !male ? const Color(0xFFD4A64A) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Female',
                    style: TextStyle(
                      color: !male ? Colors.black : Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
