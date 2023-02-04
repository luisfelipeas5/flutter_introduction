import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduction/change_button.dart';
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
      when(() => initialState.movies).thenReturn([]);

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
      "then expect to find ChangeButton",
      (widgetTester) async {
        await pumpMoviePage(widgetTester);

        final finder = find.byType(ChangeButton);
        expect(finder, findsOneWidget);
      },
    );
  });
}

class _MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieBloc {}

class _MockMovieState extends Mock implements MovieState {}
