import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/workspace_provider.dart';

import 'widgets/enterprise_sidebar.dart';
import 'widgets/enterprise_topbar.dart';
import 'widgets/biometric_status_bar.dart';

import 'widgets/ai_scan_workspace.dart';
import 'widgets/ai_tools_panel.dart';

import 'widgets/template_library_panel.dart';
import 'widgets/process_queue_panel.dart';
import 'widgets/print_layout_panel.dart';
import 'widgets/print_settings_panel.dart';

class EnterpriseWorkspaceScreen extends StatefulWidget {
  const EnterpriseWorkspaceScreen({
    super.key,
  });

  @override
  State<EnterpriseWorkspaceScreen>
      createState() =>
          _EnterpriseWorkspaceScreenState();
}

class _EnterpriseWorkspaceScreenState
    extends State<EnterpriseWorkspaceScreen> {
  @override
  Widget build(BuildContext context) {
    final imagePath =
        context
            .watch<WorkspaceProvider>()
            .imagePath;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF04070D),
              Color(0xFF0B1220),
              Color(0xFF111827),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.all(
              18,
            ),
            child: Row(
              children: [
                const EnterpriseSidebar(),

                const SizedBox(
                  width: 18,
                ),

                Expanded(
                  child: Column(
                    children: [
                      const EnterpriseTopBar(),

                      const SizedBox(
                        height: 12,
                      ),

                      const BiometricStatusBar(),

                      const SizedBox(
                        height: 12,
                      ),

                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 9,
                              child:
                                  AiScanWorkspace(
                                imagePath:
                                    imagePath,
                              ),
                            ),

                            const SizedBox(
                              width: 18,
                            ),

                            const Expanded(
                              flex: 3,
                              child:
                                  AiToolsPanel(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      SizedBox(
                        height: 240,
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 4,
                              child:
                                  TemplateLibraryPanel(),
                            ),

                            const SizedBox(
                              width: 18,
                            ),

                            const Expanded(
                              flex: 2,
                              child:
                                  ProcessQueuePanel(),
                            ),

                            const SizedBox(
                              width: 18,
                            ),

                            const Expanded(
                              flex: 4,
                              child:
                                  PrintLayoutPanel(),
                            ),

                            const SizedBox(
                              width: 18,
                            ),

                            const Expanded(
                              flex: 2,
                              child:
                                  PrintSettingsPanel(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}