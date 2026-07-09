class PhotoLayout {
  final double paperWidthMm;
  final double paperHeightMm;
  final double photoWidthMm;
  final double photoHeightMm;

  final int count;
  final int columns;
  final int rows;
  final bool rotatePhoto;
  final double marginXmm;
  final double marginYmm;
  final double gapXmm;
  final double gapYmm;

  const PhotoLayout({
    required this.paperWidthMm,
    required this.paperHeightMm,
    required this.photoWidthMm,
    required this.photoHeightMm,
    required this.count,
    required this.columns,
    required this.rows,
    required this.rotatePhoto,
    required this.marginXmm,
    required this.marginYmm,
    required this.gapXmm,
    required this.gapYmm,
  });

  double get slotWidthMm => rotatePhoto ? photoHeightMm : photoWidthMm;
  double get slotHeightMm => rotatePhoto ? photoWidthMm : photoHeightMm;

  List<PhotoPlacement> get placements {
    return List<PhotoPlacement>.generate(count, (index) {
      final column = index % columns;
      final row = index ~/ columns;

      return PhotoPlacement(
        xMm: marginXmm + (column * (slotWidthMm + gapXmm)),
        yMm: marginYmm + (row * (slotHeightMm + gapYmm)),
        widthMm: slotWidthMm,
        heightMm: slotHeightMm,
        rotatePhoto: rotatePhoto,
      );
    });
  }
}

class PhotoPlacement {
  final double xMm;
  final double yMm;
  final double widthMm;
  final double heightMm;
  final bool rotatePhoto;

  const PhotoPlacement({
    required this.xMm,
    required this.yMm,
    required this.widthMm,
    required this.heightMm,
    required this.rotatePhoto,
  });
}
