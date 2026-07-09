import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/workspace_controller.dart';

class WorkspaceStatusBar extends StatelessWidget {
  const WorkspaceStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final workspace = context.watch<WorkspaceController>();
    final resolution =
        workspace.imageWidth == null || workspace.imageHeight == null
        ? '-'
        : '${workspace.imageWidth} x ${workspace.imageHeight}';

    return Row(
      children: [
        Text(workspace.fileName ?? 'No file'),
        const SizedBox(width: 12),
        Text(resolution),
        const SizedBox(width: 12),
        Text('${(workspace.zoomValue * 100).round()}%'),
        const SizedBox(width: 12),
        Text('${workspace.rotation.round()}°'),
      ],
    );
  }
}
