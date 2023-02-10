import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_introduction/change_movie.dart';
import 'package:flutter_introduction/failure.dart';
import 'package:flutter_introduction/load_movies.dart';
import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_event.dart';
import 'package:flutter_introduction/movie_state.dart';
import 'package:flutter_introduction/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MovieController bloc;

  late LoadMovies loadMovies;
  late ChangeMovie changeMovie;

  late List<Movie> movies;
  late Failure failure;

  group("MovieBloc", () {
    setUp(() {
      loadMovies = _MockLoadMovies();
      changeMovie = _MockChangeMovie();

      failure = _MockFailure();

      bloc = MovieController(
        loadMovies,
        changeMovie,
      );
    });

    MovieController build() => bloc;

    group("MovieLoadEvent", () {
      setUp(() {
        movies = [
          _MockMovie(),
        ];

        when(loadMovies.call).thenAnswer(
          (_) => SynchronousFuture(Result.success(movies)),
        );
      });

      void act(MovieController bloc) => bloc.add(MovieLoadEvent());

      blocTest(
        "when MovieLoadEvent is added, "
        "then expect MovieState(step: loading, movies: []) and "
        "MovieState(step: loaded, movies: movies)",
        build: build,
        act: act,
        expect: () => [
          const MovieState(
            movies: [],
            step: MovieStateStep.loading,
          ),
          MovieState(
            movies: movies,
            step: MovieStateStep.loaded,
          ),
        ],
      );

      blocTest(
        "given loadMovies return a failed result, "
        "when MovieLoadEvent is added, "
        "then expect MovieState(step: loading, movies: []) and "
        "MovieState(step: failed, movies: [])",
        build: build,
        setUp: () {
          when(loadMovies.call).thenAnswer(
            (_) => SynchronousFuture(Result.failed(failure)),
          );
        },
        act: act,
        expect: () => [
          const MovieState(
            movies: [],
            step: MovieStateStep.loading,
          ),
          MovieState(
            movies: const [],
            step: MovieStateStep.failed,
            failure: failure,
          ),
        ],
      );

      blocTest(
        "when MovieLoadEvent is added, "
        "then expect to call repository.getMovies",
        build: build,
        act: act,
        verify: (bloc) {
          verify(loadMovies.call).called(1);
        },
      );
    });

    group("MovieChangeEvent", () {
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
      });

      MovieState seed() => MovieState(
            movies: movies,
            step: MovieStateStep.loaded,
          );

      void act(MovieController bloc) => bloc.add(
            MovieChangeEvent(
              index: index,
            ),
          );

      blocTest(
        "when MovieChangeEvent is added, "
        "then expect MovieState(step: loaded, movies: movies with new movie)",
        seed: seed,
        build: build,
        act: act,
        expect: () => [
          MovieState(
            movies: [
              movie0,
              movieUpdated,
              movie2,
            ],
            step: MovieStateStep.loaded,
          ),
        ],
      );

      blocTest(
        "given changeMovie return a failed result, "
        "when MovieChangeEvent is added, "
        "then expect MovieState(step: failed, failure: failure)",
        seed: seed,
        build: build,
        setUp: () {
          when(
            () => changeMovie(movie1),
          ).thenReturn(Result.failed(failure));
        },
        act: act,
        expect: () => [
          MovieState(
            movies: movies,
            step: MovieStateStep.failed,
            failure: failure,
          ),
        ],
      );

      blocTest(
        "when MovieLoadEvent is added, "
        "then expect to call repository.getMovieChanged",
        seed: seed,
        build: build,
        act: act,
        verify: (bloc) {
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
