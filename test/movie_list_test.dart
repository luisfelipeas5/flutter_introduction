import 'package:flutter/material.dart';
import 'package:flutter_introduction/modules/movies/domain/entity/movie.dart';
import 'package:flutter_introduction/modules/movies/presentation/controllers/movies/movie_controller.dart';
import 'package:flutter_introduction/modules/movies/presentation/widgets/movie_title/movie_list.dart';
import 'package:flutter_introduction/modules/movies/presentation/widgets/movie_title/movie_title.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  Get.testMode = true;

  late MovieController movieController;

  Future<void> pumpMovieList(WidgetTester tester) {
    return tester.pumpWidget(
      const MaterialApp(
        home: CustomScrollView(
          slivers: [
            MovieList(),
          ],
        ),
      ),
    );
  }

  group("MovieList", () {
    setUpAll(() {
      movieController = _MockMovieController();
      Get.put<MovieController>(movieController);
    });

    setUp(() {
      clearInteractions(movieController);
      when(() => movieController.movies).thenReturn(<Movie>[].obs);
    });

    testWidgets(
      "given a movie list with 3 movies, "
      "when pumped, "
      "then expect to find SliverList with lenth = 3",
      (widgetTester) async {
        final movies = [
          _MockMovie(),
          _MockMovie(),
          _MockMovie(),
        ];
        when(() => movieController.movies).thenReturn(movies.obs);

        await pumpMovieList(widgetTester);

        final sliverList = widgetTester.widget<SliverList>(
          find.byType(SliverList),
        );
        final delegate = sliverList.delegate as SliverChildBuilderDelegate;
        expect(delegate.childCount, 3);
      },
    );

    testWidgets(
      "given a movie list with 2 movies "
      "when pumped, "
      "then expect to find a MovieTitle for each movie in the list",
      (widgetTester) async {
        final movies = List.generate(2, (index) => _MockMovie());

        when(() => movieController.movies).thenReturn(movies.obs);

        await pumpMovieList(widgetTester);

        for (var movie in movies) {
          final movieTitleFinder = find.byWidgetPredicate(
            (widget) => widget is MovieTitle && widget.movie == movie,
          );
          expect(movieTitleFinder, findsOneWidget);
        }
      },
    );

    testWidgets(
      "given a movie list with 100 movies, "
      "when pumped, "
      "then expect to find a MovieTitle for each movie in the list",
      (widgetTester) async {
        final movies = List.generate(100, (index) => _MockMovie());

        when(() => movieController.movies).thenReturn(movies.obs);

        await pumpMovieList(widgetTester);

        for (var movie in movies) {
          final movieTitleFinder = find.byWidgetPredicate(
            (widget) => widget is MovieTitle && widget.movie == movie,
          );
          await widgetTester.dragUntilVisible(
            movieTitleFinder,
            find.byType(CustomScrollView),
            const Offset(0, 10),
          );
          expect(movieTitleFinder, findsOneWidget);
        }
      },
    );
  });
}

class _MockMovieController extends GetxService
    with Mock
    implements MovieController {}

class _MockMovie extends Mock implements Movie {
  _MockMovie() {
    when(() => title).thenReturn("mock");
  }
}
