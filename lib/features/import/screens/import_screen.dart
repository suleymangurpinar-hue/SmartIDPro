import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../workspace/controllers/workspace_controller.dart';
import '../widgets/import_dropzone.dart';

class ImportScreen extends StatefulWidget {
  const ImportScreen({super.key});

  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  String? selectedFile;

  Future<void> openFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'tif',
        'tiff',
        'dng',
        'cr2',
        'cr3',
        'raf',
        'arw',
      ],
    );

    if (result == null) return;

    final path = result.files.single.path;

    if (path == null) return;

    if (!mounted) return;

    await context.read<WorkspaceController>().loadImage(path);

    setState(() {
      selectedFile = result.files.single.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Import Center',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            Expanded(child: ImportDropzone(onOpenFile: openFile)),
            const SizedBox(height: 20),
            if (selectedFile != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF171B21),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Seçilen Dosya : $selectedFile',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
