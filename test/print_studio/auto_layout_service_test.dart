import 'package:flutter_test/flutter_test.dart';
import 'package:smart_id_pro/features/print_studio/services/auto_layout_service.dart';

void main() {
  group('AutoLayoutService', () {
    test('builds fixed 35x45 portrait production layout', () {
      final layout = AutoLayoutService.build(widthMm: 35, heightMm: 45);

      expect(layout.paperWidthMm, 150);
      expect(layout.paperHeightMm, 100);
      expect(layout.count, 8);
      expect(layout.columns, 4);
      expect(layout.rows, 2);
      expect(layout.rotatePhoto, isFalse);
      expect(layout.placements, hasLength(8));
      expect(layout.placements.first.widthMm, 35);
      expect(layout.placements.first.heightMm, 45);
    });

    test('builds fixed 45x60 rotated production layout', () {
      final layout = AutoLayoutService.build(widthMm: 45, heightMm: 60);

      expect(layout.count, 4);
      expect(layout.columns, 2);
      expect(layout.rows, 2);
      expect(layout.rotatePhoto, isTrue);
      expect(layout.placements.first.widthMm, 60);
      expect(layout.placements.first.heightMm, 45);
    });

    test('builds fixed 50x60 rotated production layout', () {
      final layout = AutoLayoutService.build(widthMm: 50, heightMm: 60);

      expect(layout.count, 4);
      expect(layout.columns, 2);
      expect(layout.rows, 2);
      expect(layout.rotatePhoto, isTrue);
      expect(layout.placements.first.widthMm, 60);
      expect(layout.placements.first.heightMm, 50);
    });

    test('builds fixed 50x50 centered production layout', () {
      final layout = AutoLayoutService.build(widthMm: 50, heightMm: 50);

      expect(layout.count, 4);
      expect(layout.columns, 2);
      expect(layout.rows, 2);
      expect(layout.rotatePhoto, isFalse);
      expect(layout.marginXmm, closeTo(50 / 3, .001));
      expect(layout.marginYmm, 0);
    });

    test('paper profile changes spacing without changing template count', () {
      final layout = AutoLayoutService.build(
        paperWidthMm: 210,
        paperHeightMm: 150,
        widthMm: 35,
        heightMm: 45,
      );

      expect(layout.count, 8);
      expect(layout.columns, 4);
      expect(layout.rows, 2);
      expect(layout.paperWidthMm, 210);
      expect(layout.paperHeightMm, 150);
      expect(layout.marginXmm, closeTo(14, .001));
      expect(layout.marginYmm, closeTo(20, .001));
    });

    test('converts millimeters and pixels at 300 DPI', () {
      expect(AutoLayoutService.mmToPx(25.4), 300);
      expect(AutoLayoutService.mmToPx(150), 1772);
      expect(AutoLayoutService.mmToPx(100), 1181);
      expect(AutoLayoutService.pxToMm(300), closeTo(25.4, .001));
    });
  });
}
