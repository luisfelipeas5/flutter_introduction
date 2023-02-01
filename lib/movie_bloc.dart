import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_introduction/movie_event.dart';
import 'package:flutter_introduction/movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc()
      : super(
          MovieState(
            changed: false,
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
        changed: _changed,
      ),
    );
  }
}
