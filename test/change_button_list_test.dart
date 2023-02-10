import 'package:flutter/material.dart';
import 'package:flutter_introduction/change_button.dart';
import 'package:flutter_introduction/change_button_list.dart';
import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_event.dart';
import 'package:flutter_introduction/movie_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MovieController movieController;

  late MovieState initialState;

  Future<void> pumpChangeButtonList(WidgetTester tester) {
    return tester.pumpWidget(
      const MaterialApp(
        home: CustomScrollView(
          slivers: [
            ChangeButtonList(),
          ],
        ),
      ),
    );
  }

  group("ChangeButtonList", () {
    setUp(() {
      initialState = _MockMovieState();

      movieController = _MockMovieController();
      Get.put<MovieController>(movieController);
      when(
        () => movieController.state,
      ).thenReturn(initialState);
      when(
        () => movieController.stateObs,
      ).thenReturn(initialState.obs);
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

        await pumpChangeButtonList(widgetTester);

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
      "then expect to find a ChangeButton for each movie in the list",
      (widgetTester) async {
        final movies = List.generate(2, (index) => _MockMovie());

        when(() => initialState.movies).thenReturn(movies);

        await pumpChangeButtonList(widgetTester);

        for (var movie in movies) {
          final changeButtonFinder = find.byWidgetPredicate(
            (widget) => widget is ChangeButton && widget.movie == movie,
          );
          expect(changeButtonFinder, findsOneWidget);
        }
      },
    );

    testWidgets(
      "given a movie list with 100 movies, "
      "when pumped, "
      "then expect to find a ChangeButton for each movie in the list",
      (widgetTester) async {
        final movies = List.generate(100, (index) => _MockMovie());

        when(() => initialState.movies).thenReturn(movies);

        await pumpChangeButtonList(widgetTester);

        for (var movie in movies) {
          final changeButtonFinder = find.byWidgetPredicate(
            (widget) => widget is ChangeButton && widget.movie == movie,
          );
          await widgetTester.dragUntilVisible(
            changeButtonFinder,
            find.byType(CustomScrollView),
            const Offset(0, 10),
          );
          expect(changeButtonFinder, findsOneWidget);
        }
      },
    );
  });
}

class _MockMovieController extends GetxService
    with Mock
    implements MovieController {}

class _MockMovieState extends Mock implements MovieState {}

class _MockMovie extends Mock implements Movie {
  _MockMovie() {
    when(() => title).thenReturn("mock");
  }
}
