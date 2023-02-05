import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduction/change_button_list.dart';
import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_event.dart';
import 'package:flutter_introduction/movie_list.dart';
import 'package:flutter_introduction/movie_state.dart';
import 'package:flutter_introduction/movie_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MovieBloc movieBloc;
  late MovieState initialState;

  Future<void> pumpMoviePage(WidgetTester tester) {
    return tester.pumpWidget(
      MaterialApp(
        home: MoviePage(
          bloc: movieBloc,
        ),
      ),
    );
  }

  group("MoviePage", () {
    setUp(() {
      movieBloc = _MockMovieBloc();

      initialState = _MockMovieState();
      final movie = _MockMovie();
      when(() => movie.title).thenReturn("mock title");
      when(() => initialState.movies).thenReturn([movie]);

      whenListen(
        movieBloc,
        const Stream<MovieState>.empty(),
        initialState: initialState,
      );
    });

    testWidgets(
      "when widget is pumped, "
      "then expect to find MovieList",
      (widgetTester) async {
        await pumpMoviePage(widgetTester);

        final finder = find.byType(MovieList);
        expect(finder, findsOneWidget);
      },
    );

    testWidgets(
      "when widget is pumped, "
      "then expect to find ChangeButtonList",
      (widgetTester) async {
        await pumpMoviePage(widgetTester);

        final finder = find.byType(ChangeButtonList);
        expect(finder, findsOneWidget);
      },
    );
  });
}

class _MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieBloc {}

class _MockMovieState extends Mock implements MovieState {}

class _MockMovie extends Mock implements Movie {}
