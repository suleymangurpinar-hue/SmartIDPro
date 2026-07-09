import 'package:flutter/material.dart';

import '../../ai_clothing/controllers/ai_clothing_controller.dart';
import '../../ai_clothing/widgets/clothing_category_bar.dart';
import '../../ai_clothing/widgets/clothing_grid.dart';
import '../../ai_clothing/widgets/engine_status_chip.dart';

class AiClothingPanel extends StatefulWidget {
  const AiClothingPanel({super.key});

  @override
  State<AiClothingPanel> createState() => _AiClothingPanelState();
}

class _AiClothingPanelState extends State<AiClothingPanel> {
  late final AiClothingController controller;

  @override
  void initState() {
    super.initState();
    controller = AiClothingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _AiClothingPanelView(controller: controller);
  }
}

class _AiClothingPanelView extends StatelessWidget {
  const _AiClothingPanelView({required this.controller});

  final AiClothingController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF111827),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color.fromRGBO(255, 255, 255, .06)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "AI CLOTHING",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Spacer(),
                    EngineStatusChip(status: controller.engineStatus),
                  ],
                ),

                const SizedBox(height: 16),

                ClothingCategoryBar(
                  currentGender: controller.currentGender,
                  onGenderChanged: controller.setGender,
                ),

                const SizedBox(height: 16),

                ClothingGrid(
                  items: controller.clothingItems,
                  selectedItem: controller.selectedClothing,
                  onSelected: controller.selectClothing,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
