import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/widgets/sidebar_widget.dart';

import '../../features/compliance/provider/compliance_provider.dart';

import '../print_lab/widgets/print_layout_preview.dart';

import 'widgets/top_toolbar.dart';
import 'widgets/photo_workspace.dart';
import 'widgets/biometric_analysis_panel.dart';
import 'widgets/document_type_panel.dart';
import 'widgets/history_panel.dart';

class WorkspaceScreen extends StatefulWidget {
  const WorkspaceScreen({super.key});

  @override
  State<WorkspaceScreen> createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen> {
  String? imagePath;

  Future<void> openPhoto() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result == null) return;

    final path = result.files.single.path;

    if (path == null) return;

    setState(() {
      imagePath = path;
    });

    if (!mounted) return;

    await context.read<ComplianceProvider>().analyzePhoto(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F1115), Color(0xFF171A21), Color(0xFF0F1115)],
          ),
        ),
        child: Row(
          children: [
            const SidebarWidget(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const TopToolbar(),

                    const SizedBox(height: 18),

                    SizedBox(
                      height: 700,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: PhotoWorkspace(imagePath: imagePath),
                          ),

                          const SizedBox(width: 18),

                          const Expanded(
                            flex: 3,
                            child: BiometricAnalysisPanel(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      height: 200,
                      child: Row(
                        children: [
                          const Expanded(flex: 2, child: DocumentTypePanel()),

                          const SizedBox(width: 18),

                          const Expanded(flex: 1, child: HistoryPanel()),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    const SizedBox(height: 270, child: PrintLayoutPreview()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: openPhoto,
        backgroundColor: const Color(0xFF4F8CFF),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.photo_library_outlined),
        label: const Text('FOTOĞRAF AÇ'),
      ),
    );
  }
}
