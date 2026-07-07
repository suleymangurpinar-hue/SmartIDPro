import 'package:flutter/material.dart';

import 'core/app_constants.dart';
import 'core/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const SmartIDProApp());
}

class SmartIDProApp extends StatelessWidget {
  const SmartIDProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.dark,
      home: const HomeScreen(),
    );
  }
}
