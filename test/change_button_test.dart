import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_introduction/change_button.dart';
import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_event.dart';
import 'package:flutter_introduction/movie_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MovieController movieBloc;
  late Movie movie;
  const index = 981;

  Future<void> pumpChangeButton(WidgetTester tester) {
    return tester.pumpWidget(
      BlocProvider<MovieController>(
        create: (context) => movieBloc,
        child: MaterialApp(
          home: ChangeButton(
            movie: movie,
            index: index,
          ),
        ),
      ),
    );
  }

  group("MovieTitle", () {
    setUp(() {
      movieBloc = _MockMovieBloc();

      movie = _MockMovie();
    });

    testWidgets(
      "when 'Trocar!' button is tapped, "
      "then expect to add MovieChangeEvent to bloc",
      (widgetTester) async {
        when(() => movie.title).thenReturn("mock title");

        await pumpChangeButton(widgetTester);

        await widgetTester.tap(find.text('Trocar mock title!'));

        verify(
          () => movieBloc.add(MovieChangeEvent(
            index: index,
          )),
        ).called(1);
      },
    );
  });
}

class _MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieController {}

class _MockMovie extends Mock implements Movie {}
