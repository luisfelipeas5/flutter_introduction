import 'package:flutter/material.dart';
import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/movie_title.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late Movie movie;

  late NavigatorObserver navigatorObserver;
  late Route<dynamic> movieDetailRoute;

  Future<void> pumpMovieTitle(WidgetTester tester) {
    return tester.pumpWidget(
      GetMaterialApp(
        navigatorObservers: [
          navigatorObserver,
        ],
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/movie-detail":
              return movieDetailRoute;
          }
          return MaterialPageRoute(builder: (_) => Container());
        },
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

      navigatorObserver = _MockNavigatorObserver();
      movieDetailRoute = MaterialPageRoute(
        builder: (_) => const Text("my-account page"),
      );
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
          () => navigatorObserver.didPush(
            movieDetailRoute,
            captureAny(),
          ),
        ).called(1);
      },
    );
  });
}

class _MockMovie extends Mock implements Movie {}

class _MockNavigatorObserver extends Mock implements NavigatorObserver {}
