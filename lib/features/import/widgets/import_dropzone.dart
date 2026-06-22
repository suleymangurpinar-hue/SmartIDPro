import 'package:flutter/material.dart';

class ImportDropzone extends StatelessWidget {
  final VoidCallback onOpenFile;

  const ImportDropzone({
    super.key,
    required this.onOpenFile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF171B21),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white12,
          width: 1,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_upload_outlined,
              size: 90,
            ),
            const SizedBox(height: 20),
            const Text(
              'Fotoğraf Sürükle Bırak',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'RAW • JPG • PNG • TIFF • DNG',
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: onOpenFile,
              icon: const Icon(Icons.folder_open),
              label: const Text('Dosya Aç'),
            ),
          ],
        ),
      ),
    );
  }
}