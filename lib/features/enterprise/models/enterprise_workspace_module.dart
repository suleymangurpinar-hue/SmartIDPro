import 'package:flutter/material.dart';

enum EnterpriseWorkspaceModule {
  scan,
  embassyDatabase,
  customerArchive,
  rawStudio,
  batchProcessing,
  reports,
  settings,
  authentication,
}

extension EnterpriseWorkspaceModuleDetails on EnterpriseWorkspaceModule {
  String get title {
    return switch (this) {
      EnterpriseWorkspaceModule.scan => 'AI Scan Workspace',
      EnterpriseWorkspaceModule.embassyDatabase => 'Embassy Database',
      EnterpriseWorkspaceModule.customerArchive => 'Customer Archive',
      EnterpriseWorkspaceModule.rawStudio => 'RAW Studio',
      EnterpriseWorkspaceModule.batchProcessing => 'Batch Processing',
      EnterpriseWorkspaceModule.reports => 'Reports',
      EnterpriseWorkspaceModule.settings => 'Settings',
      EnterpriseWorkspaceModule.authentication => 'Authentication',
    };
  }

  String get topBarTitle {
    return switch (this) {
      EnterpriseWorkspaceModule.scan => 'ICAO PASS',
      _ => title.toUpperCase(),
    };
  }

  IconData get icon {
    return switch (this) {
      EnterpriseWorkspaceModule.scan => Icons.dashboard_outlined,
      EnterpriseWorkspaceModule.embassyDatabase => Icons.public,
      EnterpriseWorkspaceModule.customerArchive => Icons.folder_shared_outlined,
      EnterpriseWorkspaceModule.rawStudio => Icons.camera_enhance_outlined,
      EnterpriseWorkspaceModule.batchProcessing => Icons.playlist_add_check,
      EnterpriseWorkspaceModule.reports => Icons.analytics_outlined,
      EnterpriseWorkspaceModule.settings => Icons.tune,
      EnterpriseWorkspaceModule.authentication =>
        Icons.admin_panel_settings_outlined,
    };
  }

  List<String> get statusLabels {
    return switch (this) {
      EnterpriseWorkspaceModule.scan => const [
        'FACE',
        'EYES',
        'HEAD',
        'BACKGROUND',
      ],
      EnterpriseWorkspaceModule.embassyDatabase => const [
        'JSON',
        'RULES',
        'ICAO',
      ],
      EnterpriseWorkspaceModule.customerArchive => const [
        'SQLITE',
        'ARCHIVE',
        'LOCAL',
      ],
      EnterpriseWorkspaceModule.rawStudio => const [
        'RAW',
        'RETOUCH',
        'CLOTHING',
      ],
      EnterpriseWorkspaceModule.batchProcessing => const [
        'QUEUE',
        'AI',
        'EXPORT',
      ],
      EnterpriseWorkspaceModule.reports => const [
        'METRICS',
        'HISTORY',
        'LOCAL',
      ],
      EnterpriseWorkspaceModule.settings => const [
        'DEFAULTS',
        'ENGINE',
        'EXPORT',
      ],
      EnterpriseWorkspaceModule.authentication => const [
        'SESSION',
        'ROLE',
        'LOCAL',
      ],
    };
  }
}
