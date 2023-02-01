import 'package:flutter/material.dart';
import 'package:flutter_introduction/movie_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("MoviePage", () {
    testWidgets(
      "when widget is pumped, "
      "then expect to find 'Rocky Balboa' text",
      (widgetTester) async {
        await widgetTester.pumpWidget(
          const MaterialApp(
            home: MoviePage(),
          ),
        );

        final textFinder = find.text("Rocky Balboa");
        expect(textFinder, findsOneWidget);
      },
    );

    testWidgets(
      "when 'Trocar!' button is tapped, "
      "then expect to find 'Creed' text",
      (widgetTester) async {
        await widgetTester.pumpWidget(
          const MaterialApp(
            home: MoviePage(),
          ),
        );

        await widgetTester.tap(find.text('Trocar!'));
        await widgetTester.pump();

        final textFinder = find.text("Creed");
        expect(textFinder, findsOneWidget);
      },
    );
  });
}
