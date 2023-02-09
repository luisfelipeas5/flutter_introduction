import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_introduction/change_movie.dart';
import 'package:flutter_introduction/load_movies.dart';
import 'package:flutter_introduction/movie_event.dart';
import 'package:flutter_introduction/movie_state.dart';
import 'package:flutter_introduction/result.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final LoadMovies _loadMovies;
  final ChangeMovie _changeMovie;

  MovieBloc(
    this._loadMovies,
    this._changeMovie,
  ) : super(
          const MovieState(
            step: MovieStateStep.loading,
            movies: [],
          ),
        ) {
    on<MovieLoadEvent>(_onLoad);
    on<MovieChangeEvent>(_onChange);
  }

  FutureOr<void> _onLoad(
    MovieLoadEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(
      step: MovieStateStep.loading,
    ));

    final loadMoviesResult = await _loadMovies();
    if (_emitFailedIfFailure(emit: emit, result: loadMoviesResult)) return null;

    emit(state.copyWith(
      step: MovieStateStep.loaded,
      movies: loadMoviesResult.data!,
    ));
  }

  FutureOr<void> _onChange(
    MovieChangeEvent event,
    Emitter<MovieState> emit,
  ) {
    final newMovies = state.movies.toList();
    final movie = state.movies[event.index];

    final changeMovieResult = _changeMovie(movie);
    if (_emitFailedIfFailure(emit: emit, result: changeMovieResult)) {
      return null;
    }

    newMovies[event.index] = changeMovieResult.data!;
    emit(
      state.copyWith(
        movies: newMovies,
      ),
    );
  }

  bool _emitFailedIfFailure({
    required Result result,
    required Emitter<MovieState> emit,
  }) {
    if (!result.isSuccess()) {
      emit(
        state.copyWith(
          step: MovieStateStep.failed,
          failure: result.failure,
        ),
      );
    }
    return !result.isSuccess();
  }
}
