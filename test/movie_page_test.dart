import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_event.dart';
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
      when(() => initialState.changed).thenReturn(false);

      whenListen(
        movieBloc,
        const Stream<MovieState>.empty(),
        initialState: initialState,
      );
    });

    testWidgets(
      "when widget is pumped, "
      "then expect to find 'Rocky Balboa' text",
      (widgetTester) async {
        await pumpMoviePage(widgetTester);

        final textFinder = find.text("Rocky Balboa");
        expect(textFinder, findsOneWidget);
      },
    );

    testWidgets(
      "when 'Trocar!' button is tapped, "
      "then expect to add MovieChangeEvent to bloc",
      (widgetTester) async {
        await pumpMoviePage(widgetTester);

        await widgetTester.tap(find.text('Trocar!'));

        verify(
          () => movieBloc.add(MovieChangeEvent()),
        ).called(1);
      },
    );

    testWidgets(
      "when movie bloc initial state has changed = true, "
      "then expect to find 'Creed' text",
      (widgetTester) async {
        when(() => initialState.changed).thenReturn(true);

        await pumpMoviePage(widgetTester);

        final textFinder = find.text("Creed");
        expect(textFinder, findsOneWidget);
      },
    );
  });
}

class _MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieBloc {}

class _MockMovieState extends Mock implements MovieState {}
