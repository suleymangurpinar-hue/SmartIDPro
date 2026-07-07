import 'package:flutter_test/flutter_test.dart';
import 'package:smart_id_pro/main.dart';

void main() {
  testWidgets('renders the Smart ID Pro desktop shell', (tester) async {
    await tester.pumpWidget(const SmartIDProApp());

    expect(find.text('Smart ID Pro'), findsOneWidget);
    expect(find.text('Photo Preview'), findsOneWidget);
    expect(find.text('10x15 Paper Preview'), findsOneWidget);
    expect(find.text('Document Types'), findsOneWidget);
    expect(find.text('35x45'), findsOneWidget);
    expect(find.text('45x60'), findsOneWidget);
    expect(find.text('50x60'), findsOneWidget);
    expect(find.text('50x50'), findsOneWidget);
    expect(find.text('Import Photo'), findsOneWidget);
  });
}
