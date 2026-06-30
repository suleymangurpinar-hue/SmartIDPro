import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enterprise/providers/workspace_provider.dart';
import '../providers/raw_studio_provider.dart';
import '../widgets/raw_ai_panel.dart';
import '../widgets/raw_adjustment_panel.dart';
import '../widgets/raw_preview_panel.dart';
import '../widgets/raw_queue_panel.dart';

class RawStudioScreen extends StatefulWidget {
  const RawStudioScreen({super.key});

  @override
  State<RawStudioScreen> createState() => _RawStudioScreenState();
}

class _RawStudioScreenState extends State<RawStudioScreen> {
  String? _lastWorkspaceImage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final workspaceImage = context.watch<WorkspaceProvider>().imagePath;

    if (workspaceImage != _lastWorkspaceImage) {
      _lastWorkspaceImage = workspaceImage;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }

        context.read<RawStudioProvider>().setImage(workspaceImage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(flex: 5, child: RawPreviewPanel()),
        SizedBox(width: 18),
        Expanded(flex: 3, child: RawAdjustmentPanel()),
        SizedBox(width: 18),
        Expanded(flex: 3, child: RawAiPanel()),
        SizedBox(width: 18),
        Expanded(flex: 3, child: RawQueuePanel()),
      ],
    );
  }
}
