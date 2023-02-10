import 'package:flutter/material.dart';
import 'package:flutter_introduction/change_button.dart';
import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/movie_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MovieController movieController;
  late Movie movie;
  const index = 981;

  Future<void> pumpChangeButton(WidgetTester tester) {
    return tester.pumpWidget(
      MaterialApp(
        home: ChangeButton(
          movie: movie,
          index: index,
        ),
      ),
    );
  }

  group("MovieTitle", () {
    setUpAll(() {
      movieController = _MockMovieController();
      Get.put<MovieController>(movieController);
    });

    setUp(() {
      clearInteractions(movieController);

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
          () => movieController.change(index),
        ).called(1);
      },
    );
  });
}

class _MockMovieController extends GetxService
    with Mock
    implements MovieController {}

class _MockMovie extends Mock implements Movie {}
