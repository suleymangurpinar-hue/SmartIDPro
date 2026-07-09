import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';

import 'features/auth/providers/auth_provider.dart';
import 'features/batch_processing/providers/batch_processing_provider.dart';
import 'features/compliance/provider/compliance_provider.dart';
import 'features/customer_archive/providers/customer_archive_provider.dart';
import 'features/embassy_database/providers/embassy_database_provider.dart';
import 'features/enterprise/providers/process_queue_provider.dart';
import 'features/enterprise/providers/workspace_provider.dart';
import 'features/enterprise/providers/face_analysis_provider.dart';
import 'features/enterprise/providers/document_preset_provider.dart';
import 'features/enterprise/providers/job_history_provider.dart';
import 'features/raw_studio/providers/raw_studio_provider.dart';
import 'features/reports/providers/reports_provider.dart';
import 'features/settings/providers/settings_provider.dart';
import 'features/print_studio/providers/print_studio_provider.dart';

import 'features/enterprise/enterprise_workspace_screen.dart';

class SmartIdProApp extends StatelessWidget {
  const SmartIdProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WorkspaceProvider()),
        ChangeNotifierProvider(create: (_) => ProcessQueueProvider()),
        ChangeNotifierProvider(create: (_) => ComplianceProvider()),
        ChangeNotifierProvider(create: (_) => FaceAnalysisProvider()),
        ChangeNotifierProvider(create: (_) => DocumentPresetProvider()),
        ChangeNotifierProvider(create: (_) => JobHistoryProvider()),
        ChangeNotifierProvider(
          create: (_) => EmbassyDatabaseProvider()..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => CustomerArchiveProvider()..load(),
        ),
        ChangeNotifierProvider(create: (_) => RawStudioProvider()),
        ChangeNotifierProvider(
          create: (_) => BatchProcessingProvider()..load(),
        ),
        ChangeNotifierProvider(create: (_) => ReportsProvider()..load()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()..load()),
        ChangeNotifierProvider(create: (_) => AuthProvider()..load()),
        ChangeNotifierProvider(create: (_) => PrintStudioProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Smart ID Pro',
            theme: AppTheme.darkTheme,
            locale: settings.locale,
            supportedLocales: const [Locale('tr'), Locale('en')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const EnterpriseWorkspaceScreen(),
          );
        },
      ),
    );
  }
}
