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
import 'package:mocktail/mocktail.dart';

void main() {
  late MovieBloc movieBloc;

  late MovieState initialState;

  Future<void> pumpMovieList(WidgetTester tester) {
    return tester.pumpWidget(
      BlocProvider<MovieBloc>(
        create: (context) => movieBloc,
        child: const MaterialApp(
          home: MovieList(),
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
      "then expect to find ListView with lenth = 3",
      (widgetTester) async {
        final movies = [
          _MockMovie(),
          _MockMovie(),
          _MockMovie(),
        ];
        when(() => initialState.movies).thenReturn(movies);

        await pumpMovieList(widgetTester);

        final listView = widgetTester.widget<ListView>(
          find.byType(ListView),
        );
        final delegate = listView.childrenDelegate as SliverChildListDelegate;
        expect(delegate.children.length, 3);
      },
    );

    testWidgets(
      "when pumped, "
      "then expect to find a MovieTitle for each movie in the list",
      (widgetTester) async {
        final movie0 = _MockMovie();
        final movie1 = _MockMovie();
        final movies = [movie0, movie1];

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
  });
}

class _MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieBloc {}

class _MockMovieState extends Mock implements MovieState {}

class _MockMovie extends Mock implements Movie {
  _MockMovie() {
    when(() => title).thenReturn("mock");
  }
}
