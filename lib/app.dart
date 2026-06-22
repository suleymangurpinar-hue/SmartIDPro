import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';

import 'features/compliance/provider/compliance_provider.dart';
import 'features/enterprise/providers/process_queue_provider.dart';
import 'features/enterprise/providers/workspace_provider.dart';

import 'features/enterprise/providers/face_analysis_provider.dart';
import 'features/enterprise/providers/document_preset_provider.dart';
import 'features/enterprise/providers/job_history_provider.dart';

import 'features/enterprise/enterprise_workspace_screen.dart';

class SmartIdProApp extends StatelessWidget {
  const SmartIdProApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
  create: (_) =>
      WorkspaceProvider(),
),

ChangeNotifierProvider(
  create: (_) =>
      ProcessQueueProvider(),
),
        ChangeNotifierProvider(
          create: (_) =>
              ComplianceProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) =>
              FaceAnalysisProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) =>
              DocumentPresetProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) =>
              JobHistoryProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:
            false,
        title: 'Smart ID Pro',

        theme:
            AppTheme.darkTheme,

        home:
            const EnterpriseWorkspaceScreen(),
      ),
    );
  }
}