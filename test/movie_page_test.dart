import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_introduction/app_toaster.dart';
import 'package:flutter_introduction/change_button_list.dart';
import 'package:flutter_introduction/failure.dart';
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
  late AppToaster appToaster;

  Future<void> pumpMoviePage(WidgetTester tester) {
    return tester.pumpWidget(
      MultiProvider(
        providers: [
          BlocProvider.value(value: movieBloc),
          Provider.value(value: appToaster),
        ],
        child: const MaterialApp(
          home: MoviePage(),
        ),
      ),
    );
  }

  group("MoviePage", () {
    setUp(() {
      movieBloc = _MockMovieBloc();

      appToaster = _MockAppToaster();

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
      "then expect to add MovieLoadEvent to MovieBloc",
      (widgetTester) async {
        await pumpMoviePage(widgetTester);

        verify(
          () => movieBloc.add(MovieLoadEvent()),
        ).called(1);
      },
    );

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

    testWidgets(
      "when movieState with step = failed is emitted, "
      "then expect to call AppToaster.showFailureToast",
      (widgetTester) async {
        final failure = _MockFailure();
        final newState = _MockMovieState();
        when(() => newState.movies).thenReturn([]);
        when(() => newState.step).thenReturn(MovieStateStep.failed);
        when(() => newState.failure).thenReturn(failure);

        whenListen(
          movieBloc,
          Stream.value(newState),
          initialState: initialState,
        );

        await pumpMoviePage(widgetTester);
        await widgetTester.pump();

        verify(
          () => appToaster.showFailureToast(failure),
        ).called(1);
      },
    );
  });
}

class _MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieBloc {}

class _MockMovieState extends Mock implements MovieState {}

class _MockMovie extends Mock implements Movie {}

class _MockAppToaster extends Mock implements AppToaster {}

class _MockFailure extends Mock implements Failure {}
