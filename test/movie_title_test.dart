import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/movie_title.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late Movie movie;

  late IModularNavigator navigatorDelegate;

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
      when(() => movie.title).thenReturn("mock title");

      navigatorDelegate = _MockModularNavigate();
      when(
        () => navigatorDelegate.pushNamed(captureAny()),
      ).thenAnswer((invocation) => SynchronousFuture(null));
      Modular.navigatorDelegate = navigatorDelegate;
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

    testWidgets(
      "when widget is tapped, "
      "then expect to call navigatorDelegate.pushNamed with 'movie-detail'",
      (widgetTester) async {
        await pumpMovieTitle(widgetTester);

        await widgetTester.tap(find.byType(MovieTitle));

        verify(
          () => navigatorDelegate.pushNamed("/movie-detail"),
        ).called(1);
      },
    );
  });
}

class _MockMovie extends Mock implements Movie {}

class _MockModularNavigate extends Mock implements IModularNavigator {}
