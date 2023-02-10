import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_introduction/change_movie.dart';
import 'package:flutter_introduction/failure.dart';
import 'package:flutter_introduction/load_movies.dart';
import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/movie_controller.dart';
import 'package:flutter_introduction/movie_controller_step.dart';
import 'package:flutter_introduction/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MovieController controller;

  late LoadMovies loadMovies;
  late ChangeMovie changeMovie;

  late List<Movie> movies;
  late Failure failure;

  group("MovieController", () {
    setUp(() {
      loadMovies = _MockLoadMovies();
      changeMovie = _MockChangeMovie();

      failure = _MockFailure();

      controller = MovieController(
        loadMovies,
        changeMovie,
      );
    });

    group("load()", () {
      setUp(() {
        movies = [
          _MockMovie(),
        ];

        when(loadMovies.call)
            .thenAnswer((_) => SynchronousFuture(Result.success(movies)));
      });

      group("step", () {
        test(
          "when load is called, "
          "then expect controller.step = loading",
          () async {
            when(loadMovies.call)
                .thenAnswer((_) => Completer<Result<List<Movie>>>().future);

            controller.load();
            expect(controller.step.value, MovieControllerStep.loading);
          },
        );

        test(
          "when load is called and wait for loadMovies return, "
          "then expect controller.step = loaded",
          () async {
            await controller.load();

            expect(controller.step.value, MovieControllerStep.loaded);
          },
        );

        test(
          "given loadMovies return a failed result, "
          "when load is called and wait for loadMovies return, "
          "then expect controller.step = loaded",
          () async {
            when(loadMovies.call)
                .thenAnswer((_) => SynchronousFuture(Result.failed(failure)));

            await controller.load();

            expect(controller.step.value, MovieControllerStep.failed);
          },
        );
      });

      group("movies", () {
        test(
          "when load is called, "
          "then expect controller.movies = []",
          () async {
            when(loadMovies.call)
                .thenAnswer((_) => Completer<Result<List<Movie>>>().future);

            controller.load();

            expect(controller.movies, <Movie>[]);
          },
        );

        test(
          "when load is called and wait for loadMovies return, "
          "then expect controller.movies = movies",
          () async {
            await controller.load();

            expect(controller.movies, movies);
          },
        );

        test(
          "given loadMovies return a failed result, "
          "when load is called and wait for loadMovies return, "
          "then expect controller.movies = []",
          () async {
            when(loadMovies.call)
                .thenAnswer((_) => SynchronousFuture(Result.failed(failure)));

            await controller.load();

            expect(controller.movies, <Movie>[]);
          },
        );
      });

      group("failure", () {
        test(
          "when load is called, "
          "then expect controller.failure = null",
          () async {
            when(loadMovies.call)
                .thenAnswer((_) => Completer<Result<List<Movie>>>().future);

            controller.load();

            expect(controller.failure.value, isNull);
          },
        );

        test(
          "when load is called and wait for loadMovies return, "
          "then expect controller.failure = null",
          () async {
            await controller.load();

            expect(controller.failure.value, isNull);
          },
        );

        test(
          "given loadMovies return a failed result, "
          "when load is called and wait for loadMovies return, "
          "then expect controller.failure = failure",
          () async {
            when(loadMovies.call)
                .thenAnswer((_) => SynchronousFuture(Result.failed(failure)));

            await controller.load();

            expect(controller.failure.value, failure);
          },
        );
      });

      test(
        "when load() is called, "
        "then expect to call repository.getMovies",
        () async {
          await controller.load();

          verify(loadMovies.call).called(1);
        },
      );
    });

    group("change()", () {
      const index = 1;
      late Movie movie0, movie1, movie2, movieUpdated;

      setUp(() {
        movie0 = _MockMovie();
        movie1 = _MockMovie();
        movie2 = _MockMovie();
        movies = [
          movie0,
          movie1,
          movie2,
        ];

        movieUpdated = _MockMovie();
        when(
          () => changeMovie.call(movie1),
        ).thenReturn(Result.success(movieUpdated));

        controller.movies = movies.obs;
      });

      group("step", () {
        test(
          "when change is called, "
          "then expect controller.step = loaded",
          () async {
            await controller.change(index);

            expect(controller.step.value, MovieControllerStep.loaded);
          },
        );

        test(
          "given changeMovie return a failed result, "
          "when change is called, "
          "then expect controller.step = loaded",
          () async {
            when(
              () => changeMovie.call(movie1),
            ).thenReturn(Result.failed(failure));

            await controller.change(index);

            expect(controller.step.value, MovieControllerStep.failed);
          },
        );
      });

      group("movies", () {
        test(
          "when change is called, "
          "then expect controller.movies = movies",
          () async {
            await controller.change(index);

            expect(controller.movies, [
              movie0,
              movieUpdated,
              movie2,
            ]);
          },
        );

        test(
          "given loadMovies return a failed result, "
          "when change is called, "
          "then expect controller.movies = []",
          () async {
            when(
              () => changeMovie.call(movie1),
            ).thenReturn(Result.failed(failure));

            await controller.change(index);

            expect(controller.movies, movies);
          },
        );
      });

      group("failure", () {
        test(
          "when change is called, "
          "then expect controller.failure = null",
          () async {
            await controller.change(index);

            expect(controller.failure.value, isNull);
          },
        );

        test(
          "given loadMovies return a failed result, "
          "when change is called, "
          "then expect controller.failure = failure",
          () async {
            when(
              () => changeMovie.call(movie1),
            ).thenReturn(Result.failed(failure));

            await controller.change(index);

            expect(controller.failure.value, failure);
          },
        );
      });

      test(
        "when change() is called, "
        "then expect to call changeMovie with movie1",
        () async {
          await controller.change(index);

          verify(
            () => changeMovie.call(movie1),
          ).called(1);
        },
      );
    });
  });
}

class _MockLoadMovies extends Mock implements LoadMovies {}

class _MockChangeMovie extends Mock implements ChangeMovie {}

class _MockMovie extends Mock implements Movie {}

class _MockFailure extends Mock implements Failure {}
