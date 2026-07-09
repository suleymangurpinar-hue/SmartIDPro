import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ai_background/controllers/ai_background_controller.dart';
import '../../ai_background/widgets/background_grid.dart';
import '../../workspace/controllers/workspace_controller.dart';

class BackgroundPanel extends StatefulWidget {
  const BackgroundPanel({super.key});

  @override
  State<BackgroundPanel> createState() => _BackgroundPanelState();
}

class _BackgroundPanelState extends State<BackgroundPanel> {
  late final AiBackgroundController controller;

  @override
  void initState() {
    super.initState();
    controller = AiBackgroundController(
      workspace: context.read<WorkspaceController>(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BackgroundPanelView(controller: controller);
  }
}

class _BackgroundPanelView extends StatelessWidget {
  const _BackgroundPanelView({required this.controller});

  final AiBackgroundController controller;

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
                const Text(
                  "BACKGROUND",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                BackgroundGrid(
                  items: controller.backgroundItems,
                  selectedItem: controller.selectedBackground,
                  onSelected: controller.selectBackground,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
