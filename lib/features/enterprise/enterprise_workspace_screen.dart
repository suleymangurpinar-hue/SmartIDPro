import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/providers/auth_provider.dart';
import '../auth/screens/authentication_screen.dart';
import '../batch_processing/screens/batch_processing_screen.dart';
import '../customer_archive/screens/customer_archive_screen.dart';
import '../embassy_database/screens/embassy_database_screen.dart';
import '../raw_studio/screens/raw_studio_screen.dart';
import '../reports/screens/reports_screen.dart';
import '../settings/screens/settings_screen.dart';
import '../print_studio/widgets/print_studio_panel.dart';

import 'models/enterprise_workspace_module.dart';
import 'providers/workspace_provider.dart';

import 'widgets/enterprise_sidebar.dart';
import 'widgets/enterprise_topbar.dart';
import 'widgets/biometric_status_bar.dart';
import 'widgets/ai_scan_workspace.dart';
import 'widgets/ai_tools_panel.dart';
import 'widgets/template_library_panel.dart';
import 'widgets/process_queue_panel.dart';
import 'widgets/print_settings_panel.dart';

class EnterpriseWorkspaceScreen
    extends StatefulWidget {
  const EnterpriseWorkspaceScreen({
    super.key,
  });

  @override
  State<EnterpriseWorkspaceScreen>
      createState() =>
          _EnterpriseWorkspaceScreenState();
}

class _EnterpriseWorkspaceScreenState
    extends State<
        EnterpriseWorkspaceScreen> {
  EnterpriseWorkspaceModule
      _selectedModule =
      EnterpriseWorkspaceModule.scan;

  @override
  Widget build(BuildContext context) {
    final imagePath =
        context
            .watch<WorkspaceProvider>()
            .imagePath;

    final authUser =
        context
            .watch<AuthProvider>()
            .user;

    return Scaffold(
      body: Container(
        decoration:
            const BoxDecoration(
          gradient: LinearGradient(
            begin:
                Alignment.topLeft,
            end:
                Alignment.bottomRight,
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
                EnterpriseSidebar(
                  selected:
                      _selectedModule,
                  onSelected:
                      (module) {
                    setState(() {
                      _selectedModule =
                          module;
                    });
                  },
                ),
                const SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: Column(
                    children: [
                      EnterpriseTopBar(
                        title:
                            _selectedModule
                                .topBarTitle,
                        score:
                            _selectedModule ==
                                    EnterpriseWorkspaceModule
                                        .scan
                                ? '98%'
                                : null,
                        showImportButton:
                            _selectedModule ==
                                    EnterpriseWorkspaceModule
                                        .scan ||
                                _selectedModule ==
                                    EnterpriseWorkspaceModule
                                        .rawStudio ||
                                _selectedModule ==
                                    EnterpriseWorkspaceModule
                                        .batchProcessing,
                        statusLabels:
                            _selectedModule
                                .statusLabels,
                        userLabel:
                            authUser
                                    ?.displayName ??
                                'SIGNED OUT',
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child:
                            _buildModuleBody(
                          imagePath,
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

  Widget _buildModuleBody(
    String? imagePath,
  ) {
    return switch (
        _selectedModule) {
      EnterpriseWorkspaceModule
              .scan =>
          _ScanWorkspaceBody(
            imagePath:
                imagePath,
          ),
      EnterpriseWorkspaceModule
              .embassyDatabase =>
          const EmbassyDatabaseScreen(),
      EnterpriseWorkspaceModule
              .customerArchive =>
          const CustomerArchiveScreen(),
      EnterpriseWorkspaceModule
              .rawStudio =>
          const RawStudioScreen(),
      EnterpriseWorkspaceModule
              .batchProcessing =>
          const BatchProcessingScreen(),
      EnterpriseWorkspaceModule
              .reports =>
          const ReportsScreen(),
      EnterpriseWorkspaceModule
              .settings =>
          const SettingsScreen(),
      EnterpriseWorkspaceModule
              .authentication =>
          const AuthenticationScreen(),
    };
  }
}

class _ScanWorkspaceBody
    extends StatelessWidget {
  const _ScanWorkspaceBody({
    required this.imagePath,
  });

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          height: 280,
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
                    PrintStudioPanel(),
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
    );
  }
}