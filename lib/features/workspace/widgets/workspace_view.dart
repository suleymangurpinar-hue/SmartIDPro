import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/workspace_controller.dart';

class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  @override
  Widget build(BuildContext context) {
    final workspace = context.watch<WorkspaceController>();
    final imagePath = workspace.imagePath;

    if (imagePath == null) {
      return const SizedBox.shrink();
    }

    return Transform.rotate(
      angle: workspace.rotation * 3.141592653589793 / 180,
      child: Transform.scale(
        scale: workspace.scale,
        child: Image.file(File(imagePath), fit: BoxFit.contain),
      ),
    );
  }
}
