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

  bool _changed = false;

  FutureOr<void> _onChange(
    MovieChangeEvent event,
    Emitter<MovieState> emit,
  ) {
    _changed = !_changed;
    emit(
      MovieState(
        movies: _movies,
      ),
    );
  }

  List<Movie> get _movies => _getMovies(changed: _changed);

  static List<Movie> _getMovies({
    required bool changed,
  }) {
    return List.generate(100, (index) {
      final prefix = changed ? "Creed" : "Rocky Balboa";
      return Movie(title: "$prefix $index");
    });
  }
}
