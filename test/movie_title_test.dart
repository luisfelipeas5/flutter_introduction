import 'package:flutter/material.dart';
import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/movie_title.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late Movie movie;

  Future<void> pumpMovieTitle(WidgetTester tester) {
    return tester.pumpWidget(
      MaterialApp(
        home: MovieTitle(
          movie: movie,
        ),
      ),
    );
  }

  group("MovieTitle", () {
    setUp(() {
      movie = _MockMovie();
    });

    testWidgets(
      "when widget is pumped, "
      "then expect to find Text with movie title",
      (widgetTester) async {
        const title = "mock title";
        when(() => movie.title).thenReturn(title);

        await pumpMovieTitle(widgetTester);

        final textFinder = find.text(title);
        expect(textFinder, findsOneWidget);
      },
    );
  });
}

class _MockMovie extends Mock implements Movie {}
