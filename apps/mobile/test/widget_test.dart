import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app.dart';

void main() {
  testWidgets('ScamPlayApp renders with bilingual switcher', (WidgetTester tester) async {
    await tester.pumpWidget(const ScamPlayApp());

    // Verify initial Khmer title is present
    expect(find.textContaining('ScamPlay'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);

    // Tap language switcher to English
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    // Verify language changed to English and toggle shows Khmer option
    expect(find.text('ភាសាខ្មែរ'), findsOneWidget);
  });
}
