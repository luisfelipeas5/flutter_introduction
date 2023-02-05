import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/movie_event.dart';
import 'package:flutter_introduction/movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc()
      : super(
          MovieState(
            movies: _getMovies(changed: false),
          ),
        ) {
    on<MovieChangeEvent>(_onChange);
  }

  FutureOr<void> _onChange(
    MovieChangeEvent event,
    Emitter<MovieState> emit,
  ) {
    final newMovies = state.movies.toList();
    newMovies[event.index] = _getMovieChanged(index: event.index);

    emit(
      MovieState(
        movies: newMovies,
      ),
    );
  }

  static List<Movie> _getMovies({
    required bool changed,
  }) {
    return List.generate(15, (index) {
      final prefix = changed ? "Creed" : "Rocky Balboa";
      return Movie(title: "$prefix $index");
    });
  }

  Movie _getMovieChanged({
    required int index,
  }) {
    final movie = state.movies[index];

    final newTitlePrefix = _getTitleChanged(movie.title);

    return movie.copyWith(
      title: "$newTitlePrefix $index",
    );
  }

  String _getTitleChanged(String title) {
    if (title.contains("Creed")) {
      return "Rocky Balboa";
    }
    return "Creed";
  }
}
