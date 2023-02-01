import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_event.dart';
import 'package:flutter_introduction/movie_state.dart';
import 'package:flutter_introduction/movie_title.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MovieBloc movieBloc;
  late MovieState initialState;

  Future<void> pumpMovieTitle(WidgetTester tester) {
    return tester.pumpWidget(
      BlocProvider<MovieBloc>(
        create: (context) => movieBloc,
        child: const MaterialApp(
          home: MovieTitle(),
        ),
      ),
    );
  }

  group("MovieTitle", () {
    setUp(() {
      movieBloc = _MockMovieBloc();

      initialState = _MockMovieState();
      when(() => initialState.title).thenReturn("Creed");

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
        const title = "mock title";
        when(() => initialState.title).thenReturn(title);

        await pumpMovieTitle(widgetTester);

        final textFinder = find.text(title);
        expect(textFinder, findsOneWidget);
      },
    );
  });
}

class _MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieBloc {}

class _MockMovieState extends Mock implements MovieState {}
