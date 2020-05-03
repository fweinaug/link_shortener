import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/router.dart';
import 'package:link_shortener/views/generate.dart';
import 'package:link_shortener/views/redirect.dart';
import 'package:link_shortener/views/report.dart';

void main() {
  group('Router', () {
    testWidgets('Route to GeneratePage', (WidgetTester tester) async {
      final route = Router.onGenerateRoute(RouteSettings(name: '/'));

      expect(route, isInstanceOf<MaterialPageRoute>());

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Build widget for the route
              final routeBuilder = (route as MaterialPageRoute).builder;
              final widget = routeBuilder(context);

              expect(widget, isInstanceOf<GeneratePage>());

              return widget;
            },
          ),
        )
      );
    });

    testWidgets('Route to RedirectPage', (WidgetTester tester) async {
      final route = Router.onGenerateRoute(RouteSettings(name: '/abcde'));

      expect(route, isInstanceOf<MaterialPageRoute>());

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Build widget for the route
              final routeBuilder = (route as MaterialPageRoute).builder;
              final widget = routeBuilder(context);

              expect(widget, isInstanceOf<RedirectPage>());
              expect((widget as RedirectPage).linkEnding, 'abcde');

              return widget;
            },
          ),
        )
      );
    });

    testWidgets('Route to ReportPage', (WidgetTester tester) async {
      final route = Router.onGenerateRoute(RouteSettings(name: '/abcde~'));

      expect(route, isInstanceOf<MaterialPageRoute>());

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Build widget for the route
              final routeBuilder = (route as MaterialPageRoute).builder;
              final widget = routeBuilder(context);

              expect(widget, isInstanceOf<ReportPage>());
              expect((widget as ReportPage).linkEnding, 'abcde');

              return widget;
            },
          ),
        )
      );
    });
  });
}
