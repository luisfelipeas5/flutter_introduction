import 'package:equatable/equatable.dart';
import 'package:flutter_introduction/failure.dart';
import 'package:flutter_introduction/movie.dart';

enum MovieStateStep {
  loading,
  loaded,
  failed,
}

class MovieState extends Equatable {
  final List<Movie> movies;
  final MovieStateStep step;
  final Failure? failure;

  const MovieState({
    required this.movies,
    required this.step,
    this.failure,
  });

  MovieState copyWith({
    List<Movie>? movies,
    MovieStateStep? step,
    Failure? failure,
  }) {
    return MovieState(
      movies: movies ?? this.movies,
      step: step ?? this.step,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        movies,
        step,
      ];
}
