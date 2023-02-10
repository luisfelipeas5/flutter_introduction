import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_event.dart';
import 'package:flutter_introduction/movie_list.dart';
import 'package:flutter_introduction/movie_state.dart';
import 'package:flutter_introduction/movie_title.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  Get.testMode = true;

  late MovieController movieBloc;

  late MovieState initialState;

  Future<void> pumpMovieList(WidgetTester tester) {
    return tester.pumpWidget(
      BlocProvider<MovieController>(
        create: (context) => movieBloc,
        child: const MaterialApp(
          home: CustomScrollView(
            slivers: [
              MovieList(),
            ],
          ),
        ),
      ),
    );
  }

  group("MovieList", () {
    setUp(() {
      initialState = _MockMovieState();

      movieBloc = _MockMovieBloc();

      whenListen(
        movieBloc,
        const Stream<MovieState>.empty(),
        initialState: initialState,
      );
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
        when(() => initialState.movies).thenReturn(movies);

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

        when(() => initialState.movies).thenReturn(movies);

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

        when(() => initialState.movies).thenReturn(movies);

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

class _MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieController {}

class _MockMovieState extends Mock implements MovieState {}

class _MockMovie extends Mock implements Movie {
  _MockMovie() {
    when(() => title).thenReturn("mock");
  }
}
