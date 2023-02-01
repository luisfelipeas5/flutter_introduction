import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_introduction/change_button.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_event.dart';
import 'package:flutter_introduction/movie_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MovieBloc movieBloc;

  Future<void> pumpChangeButton(WidgetTester tester) {
    return tester.pumpWidget(
      BlocProvider<MovieBloc>(
        create: (context) => movieBloc,
        child: const MaterialApp(
          home: ChangeButton(),
        ),
      ),
    );
  }

  group("MovieTitle", () {
    setUp(() {
      movieBloc = _MockMovieBloc();
    });

    testWidgets(
      "when 'Trocar!' button is tapped, "
      "then expect to add MovieChangeEvent to bloc",
      (widgetTester) async {
        await pumpChangeButton(widgetTester);

        await widgetTester.tap(find.text('Trocar!'));

        verify(
          () => movieBloc.add(MovieChangeEvent()),
        ).called(1);
      },
    );
  });
}

class _MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieBloc {}
