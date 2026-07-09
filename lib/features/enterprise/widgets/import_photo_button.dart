import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../compliance/services/face_detector_service.dart';
import '../providers/document_preset_provider.dart';
import '../providers/process_queue_provider.dart';
import '../providers/workspace_provider.dart';
import '../services/file_name_service.dart';
import '../services/photo_import_service.dart';

class ImportPhotoButton extends StatelessWidget {
  const ImportPhotoButton({
    super.key,
  });

  Future<void> _autoCrop(
    BuildContext context,
    String imagePath,
  ) async {
    try {
      final face =
          await FaceDetectorService()
              .detectFace(
        imagePath,
      );

      debugPrint(
        'FACE: '
        '${face.x} '
        '${face.y} '
        '${face.width} '
        '${face.height}',
      );

      if (!face.faceFound) {
        return;
      }

      if (!context.mounted) {
        return;
      }

      final preset =
          context.read<DocumentPresetProvider>();

      final workspace =
          context.read<WorkspaceProvider>();

      workspace.calculateAutoCrop(
        faceX: face.x,
        faceY: face.y,
        faceWidth: face.width,
        faceHeight: face.height,
        targetHeadRatio:
            preset.targetHeadRatio,
        targetEyeRatio:
            preset.targetEyeRatio,
      );

      debugPrint(
        'AUTO CROP => '
        'scale:${workspace.scale} '
        'offset:${workspace.offset}',
      );
    } catch (e) {
      debugPrint(
        'AUTO CROP ERROR: $e',
      );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n =
        AppLocalizations.of(context)!;

    return ElevatedButton.icon(
      icon: const Icon(
        Icons.add_photo_alternate,
      ),
      label: Text(
        l10n.importPhoto,
      ),
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

        final workspace =
            context.read<
                WorkspaceProvider>();

        workspace.clear();
        workspace.setImage(path);

        await _autoCrop(
          context,
          path,
        );

        if (!context.mounted) {
          return;
        }

        context
            .read<
                ProcessQueueProvider>()
            .add(
              FileNameService.extract(
                path,
              ),
            );
      },
    );
  }
}