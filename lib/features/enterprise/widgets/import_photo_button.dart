import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workspace_provider.dart';
import '../providers/process_queue_provider.dart';

import '../services/photo_import_service.dart';
import '../services/file_name_service.dart';

class ImportPhotoButton extends StatelessWidget {
  const ImportPhotoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final path =
            await PhotoImportService
                .pickPhoto();

        if (path == null) {
          return;
        }

        if (!context.mounted) {
          return;
        }

        context
            .read<WorkspaceProvider>()
            .setImage(path);

        context
            .read<
                ProcessQueueProvider>()
            .add(
              FileNameService
                  .extract(path),
            );
      },
      icon: const Icon(
        Icons.add_photo_alternate,
      ),
      label: const Text(
        "IMPORT PHOTO",
      ),
    );
  }
}