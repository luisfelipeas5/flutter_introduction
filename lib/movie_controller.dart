import 'dart:async';

import 'package:flutter_introduction/change_movie.dart';
import 'package:flutter_introduction/failure.dart';
import 'package:flutter_introduction/load_movies.dart';
import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/movie_controller_step.dart';
import 'package:flutter_introduction/result.dart';
import 'package:get/get.dart';

class MovieController extends GetxController {
  final LoadMovies _loadMovies;
  final ChangeMovie _changeMovie;

  RxList<Movie> movies = <Movie>[].obs;
  Rx<MovieControllerStep> step = MovieControllerStep.loading.obs;
  Rx<Failure?> failure = Rx(null);

  MovieController(
    this._loadMovies,
    this._changeMovie,
  );

  FutureOr<void> load() async {
    step.value = MovieControllerStep.loading;

    final loadMoviesResult = await _loadMovies();
    if (_emitFailedIfFailure(result: loadMoviesResult)) return null;

    step.value = MovieControllerStep.loaded;
    movies.assignAll(loadMoviesResult.data!);
  }

  FutureOr<void> change(
    int index,
  ) {
    final movie = movies[index];

    final changeMovieResult = _changeMovie(movie);
    if (_emitFailedIfFailure(result: changeMovieResult)) {
      return null;
    }

    movies[index] = changeMovieResult.data!;
    step.value = MovieControllerStep.loaded;
  }

  bool _emitFailedIfFailure({
    required Result result,
  }) {
    if (!result.isSuccess()) {
      step.value = MovieControllerStep.failed;
      failure.value = result.failure;
    }
    return !result.isSuccess();
  }
}
