import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_event.dart';
import 'package:flutter_introduction/movie_state.dart';
import 'package:flutter_introduction/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MovieBloc bloc;

  late Repository repository;

  late List<Movie> movies;

  group("MovieBloc", () {
    setUp(() {
      repository = _MockRepository();

      bloc = MovieBloc(
        repository,
      );
    });

    MovieBloc build() => bloc;

    group("MovieLoadEvent", () {
      setUp(() {
        movies = [
          _MockMovie(),
        ];

        when(repository.getMovies).thenAnswer(
          (_) => SynchronousFuture(movies),
        );
      });

      void act(MovieBloc bloc) => bloc.add(MovieLoadEvent());

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
        "when MovieLoadEvent is added, "
        "then expect to call repository.getMovies",
        build: build,
        act: act,
        verify: (bloc) {
          verify(repository.getMovies).called(1);
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
          () => repository.getMovieChanged(movie1),
        ).thenReturn(movieUpdated);
      });

      MovieState seed() => MovieState(
            movies: movies,
            step: MovieStateStep.loaded,
          );

      void act(MovieBloc bloc) => bloc.add(
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
        "when MovieLoadEvent is added, "
        "then expect to call repository.getMovieChanged",
        seed: seed,
        build: build,
        act: act,
        verify: (bloc) {
          verify(
            () => repository.getMovieChanged(movie1),
          ).called(1);
        },
      );
    });
  });
}

class _MockRepository extends Mock implements Repository {}

class _MockMovie extends Mock implements Movie {}
