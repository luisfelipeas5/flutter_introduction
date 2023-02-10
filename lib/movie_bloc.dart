import 'dart:async';

import 'package:flutter_introduction/change_movie.dart';
import 'package:flutter_introduction/load_movies.dart';
import 'package:flutter_introduction/movie_event.dart';
import 'package:flutter_introduction/movie_state.dart';
import 'package:flutter_introduction/result.dart';
import 'package:get/get.dart';

class MovieController extends GetxController {
  final LoadMovies _loadMovies;
  final ChangeMovie _changeMovie;

  MovieState get state => stateObs.value;
  var stateObs = const MovieState(
    step: MovieStateStep.loading,
    movies: [],
  ).obs;

  MovieController(
    this._loadMovies,
    this._changeMovie,
  );

  FutureOr<void> load() async {
    _update(state.copyWith(
      step: MovieStateStep.loading,
    ));

    final loadMoviesResult = await _loadMovies();
    if (_emitFailedIfFailure(result: loadMoviesResult)) return null;

    _update(state.copyWith(
      step: MovieStateStep.loaded,
      movies: loadMoviesResult.data!,
    ));
  }

  FutureOr<void> change(
    int index,
  ) {
    final newMovies = state.movies.toList();
    final movie = state.movies[index];

    final changeMovieResult = _changeMovie(movie);
    if (_emitFailedIfFailure(result: changeMovieResult)) {
      return null;
    }

    newMovies[index] = changeMovieResult.data!;
    _update(state.copyWith(
      movies: newMovies,
    ));
  }

  bool _emitFailedIfFailure({
    required Result result,
  }) {
    if (!result.isSuccess()) {
      _update(
        state.copyWith(
          step: MovieStateStep.failed,
          failure: result.failure,
        ),
      );
    }
    return !result.isSuccess();
  }

  void _update(MovieState newState) {
    stateObs.update(
      (val) {
        stateObs = newState.obs;
      },
    );
  }
}
