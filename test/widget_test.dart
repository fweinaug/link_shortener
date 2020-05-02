import 'package:flutter_test/flutter_test.dart';

import 'package:link_shortener/main.dart';

void main() {
  testWidgets('Home page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(App());

    // Verify that our home page launches
    expect(find.text('Shortie'), findsOneWidget);
  });
}
