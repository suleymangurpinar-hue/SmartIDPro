import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_constants.dart';
import '../engine/print_engine.dart';
import '../models/photo_type.dart';
import '../services/file_service.dart';
import '../widgets/glass_panel.dart';
import '../widgets/preview_canvas.dart';

final class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final class _HomeScreenState extends State<HomeScreen> {
  static const PrintEngine _printEngine = PrintEngine();

  final FileService _fileService = const FileService();

  PhotoType _selectedType = PhotoType.p35x45;
  ui.Image? _photoImage;
  String? _photoFileName;
  bool _isImporting = false;

  @override
  void dispose() {
    _photoImage?.dispose();
    super.dispose();
  }

  Future<void> _importPhoto() async {
    if (_isImporting) {
      return;
    }

    setState(() {
      _isImporting = true;
    });

    ui.Image? decodedImage;

    try {
      final file = await _fileService.pickImage();

      if (!mounted) {
        return;
      }

      if (file == null) {
        return;
      }

      if (!_fileService.isSupported(file)) {
        _showMessage('Unsupported image format.');
        return;
      }

      decodedImage = await _fileService.decodeImage(file);

      if (!mounted) {
        return;
      }

      final previousImage = _photoImage;

      setState(() {
        _photoImage = decodedImage;
        _photoFileName = _fileService.fileName(file);
      });

      if (previousImage != null) {
        _disposeImageAfterFrame(previousImage);
      }

      decodedImage = null;
    } catch (_) {
      if (!mounted) {
        return;
      }

      _showMessage('The selected image could not be imported.');
    } finally {
      decodedImage?.dispose();

      if (mounted && _isImporting) {
        setState(() {
          _isImporting = false;
        });
      }
    }
  }

  void _selectPhotoType(PhotoType type) {
    if (_selectedType == type) {
      return;
    }

    setState(() {
      _selectedType = type;
    });
  }

  void _disposeImageAfterFrame(ui.Image image) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      image.dispose();
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(color: AppColors.background),
        child: Column(
          children: <Widget>[
            const _AppHeader(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: GlassPanel(
                              title: 'Photo Preview',
                              child: _PhotoPreview(
                                image: _photoImage,
                                fileName: _photoFileName,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppConstants.sectionSpacing),
                          Expanded(
                            child: GlassPanel(
                              title: '10x15 Paper Preview',
                              child: _PaperPreview(
                                selectedType: _selectedType,
                                image: _photoImage,
                                printEngine: _printEngine,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppConstants.sectionSpacing),
                    SizedBox(
                      height: 176,
                      child: GlassPanel(
                        title: 'Document Types',
                        child: _DocumentControls(
                          selectedType: _selectedType,
                          onTypeSelected: _selectPhotoType,
                          onImportPressed: _importPhoto,
                          isImporting: _isImporting,
                          fileName: _photoFileName,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _AppHeader extends StatelessWidget {
  const _AppHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.96),
        border: Border(
          bottom: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.24),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Text(
            AppConstants.appName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

final class _PhotoPreview extends StatelessWidget {
  const _PhotoPreview({required this.image, required this.fileName});

  final ui.Image? image;
  final String? fileName;

  @override
  Widget build(BuildContext context) {
    final image = this.image;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstants.controlCornerRadius),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.72),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: image == null
            ? const _EmptyPhotoPreview()
            : Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: RawImage(
                        image: image,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  if (fileName != null)
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 12,
                      child: _FileNameBadge(fileName: fileName!),
                    ),
                ],
              ),
      ),
    );
  }
}

final class _EmptyPhotoPreview extends StatelessWidget {
  const _EmptyPhotoPreview();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.image_outlined,
            size: 42,
            color: AppColors.primary.withValues(alpha: 0.82),
          ),
          const SizedBox(height: 12),
          Text(
            'No photo selected',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

final class _PaperPreview extends StatelessWidget {
  const _PaperPreview({
    required this.selectedType,
    required this.image,
    required this.printEngine,
  });

  final PhotoType selectedType;
  final ui.Image? image;
  final PrintEngine printEngine;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = math.min(
          constraints.maxWidth,
          constraints.maxHeight * AppConstants.paperAspectRatio,
        );

        return Center(
          child: SizedBox(
            width: width,
            child: PreviewCanvas(
              photoType: selectedType,
              image: image,
              printEngine: printEngine,
            ),
          ),
        );
      },
    );
  }
}

final class _DocumentControls extends StatelessWidget {
  const _DocumentControls({
    required this.selectedType,
    required this.onTypeSelected,
    required this.onImportPressed,
    required this.isImporting,
    required this.fileName,
  });

  final PhotoType selectedType;
  final ValueChanged<PhotoType> onTypeSelected;
  final VoidCallback onImportPressed;
  final bool isImporting;
  final String? fileName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SegmentedButton<PhotoType>(
          showSelectedIcon: false,
          segments: PhotoType.values
              .map<ButtonSegment<PhotoType>>(
                (type) => ButtonSegment<PhotoType>(
                  value: type,
                  label: Text(type.id),
                  tooltip: type.title,
                ),
              )
              .toList(growable: false),
          selected: <PhotoType>{selectedType},
          onSelectionChanged: (selection) {
            onTypeSelected(selection.first);
          },
        ),
        const Spacer(),
        Row(
          children: <Widget>[
            FilledButton.icon(
              onPressed: isImporting ? null : onImportPressed,
              icon: isImporting
                  ? const SizedBox.square(
                      dimension: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.file_open_outlined),
              label: Text(isImporting ? 'Importing...' : 'Import Photo'),
            ),
            if (fileName != null) ...<Widget>[
              const SizedBox(width: 14),
              Expanded(child: _FileNameBadge(fileName: fileName!)),
            ],
          ],
        ),
      ],
    );
  }
}

final class _FileNameBadge extends StatelessWidget {
  const _FileNameBadge({required this.fileName});

  final String fileName;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.74),
        borderRadius: BorderRadius.circular(AppConstants.controlCornerRadius),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.22)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Text(
          fileName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
