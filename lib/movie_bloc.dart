import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_introduction/movie_event.dart';
import 'package:flutter_introduction/movie_state.dart';
import 'package:flutter_introduction/repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final Repository _repository;

  MovieBloc(
    this._repository,
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

    final movies = await _repository.getMovies();

    emit(state.copyWith(
      step: MovieStateStep.loaded,
      movies: movies,
    ));
  }

  FutureOr<void> _onChange(
    MovieChangeEvent event,
    Emitter<MovieState> emit,
  ) {
    final newMovies = state.movies.toList();
    final movie = state.movies[event.index];
    newMovies[event.index] = _repository.getMovieChanged(movie);

    emit(
      state.copyWith(
        movies: newMovies,
      ),
    );
  }
}
