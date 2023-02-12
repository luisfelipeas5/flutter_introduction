import 'package:flutter/material.dart';
import 'package:flutter_introduction/feature_core/app_toaster.dart';
import 'package:flutter_introduction/modules/movies/presentation/controllers/movies/movie_controller.dart';
import 'package:flutter_introduction/modules/movies/presentation/controllers/movies/movie_controller_step.dart';
import 'package:flutter_introduction/modules/movies/presentation/widgets/change_button/change_button_list.dart';
import 'package:flutter_introduction/modules/movies/presentation/widgets/movie_title/movie_list.dart';
import 'package:flutter_introduction/modules/shared/core/failure.dart';
import 'package:flutter_introduction/modules/movies/domain/entity/movie.dart';
import 'package:flutter_introduction/modules/movies/presentation/pages/movie_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MovieController movieController;
  late AppToaster appToaster;

  Future<void> pumpMoviePage(WidgetTester tester) {
    return tester.pumpWidget(
      const MaterialApp(
        home: MoviePage(),
      ),
    );
  }

  group("MoviePage", () {
    setUpAll(() {
      appToaster = _MockAppToaster();

      Get.put<AppToaster>(appToaster);

      movieController = _MockMovieController();
      Get.put<MovieController>(movieController);
    });

    setUp(() {
      clearInteractions(appToaster);
      clearInteractions(movieController);

      final movie = _MockMovie();
      when(() => movie.title).thenReturn("mock title");
      when(() => movieController.movies).thenReturn([movie].obs);
      when(() => movieController.step).thenReturn(
        MovieControllerStep.loaded.obs,
      );
    });

    testWidgets(
      "when widget is pumped, "
      "then expect to call MovieController.load",
      (widgetTester) async {
        await pumpMoviePage(widgetTester);

        verify(movieController.load).called(1);
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
        when(() => movieController.movies).thenReturn(<Movie>[].obs);

        final step = MovieControllerStep.loaded.obs;
        when(() => movieController.step).thenReturn(step);

        final failure = _MockFailure();
        when(() => movieController.failure).thenReturn(failure.obs);

        await pumpMoviePage(widgetTester);

        when(() => movieController.step)
            .thenReturn(MovieControllerStep.failed.obs);
        step.update((val) => val = MovieControllerStep.failed);
        await widgetTester.pump();

        verify(
          () => appToaster.showFailureToast(failure),
        ).called(1);
      },
    );

    group("CircularProgressIndicator", () {
      testWidgets(
        "given a controller.step == loaded"
        "when widget is pumped, "
        "then expect not expect to find CircularProgressIndicator",
        (widgetTester) async {
          when(
            () => movieController.step,
          ).thenReturn(MovieControllerStep.loaded.obs);

          await pumpMoviePage(widgetTester);

          final finder = find.byType(CircularProgressIndicator);
          expect(finder, findsNothing);
        },
      );

      testWidgets(
        "given a controller.step == failed"
        "when widget is pumped, "
        "then expect not expect to find CircularProgressIndicator",
        (widgetTester) async {
          when(
            () => movieController.step,
          ).thenReturn(MovieControllerStep.failed.obs);

          await pumpMoviePage(widgetTester);

          final finder = find.byType(CircularProgressIndicator);
          expect(finder, findsNothing);
        },
      );

      testWidgets(
        "given a controller.step == loading"
        "when widget is pumped, "
        "then expect not expect to find CircularProgressIndicator",
        (widgetTester) async {
          when(
            () => movieController.step,
          ).thenReturn(MovieControllerStep.loading.obs);

          await pumpMoviePage(widgetTester);

          final finder = find.byType(CircularProgressIndicator);
          expect(finder, findsOneWidget);
        },
      );
    });
  });
}

class _MockMovieController extends GetxService
    with Mock
    implements MovieController {}

class _MockMovie extends Mock implements Movie {}

class _MockAppToaster extends Mock implements AppToaster {}

class _MockFailure extends Mock implements Failure {}
