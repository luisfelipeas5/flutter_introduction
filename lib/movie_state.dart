import 'package:equatable/equatable.dart';
import 'package:flutter_introduction/movie.dart';

enum MovieStateStep {
  loading,
  loaded,
  failed,
}

class MovieState extends Equatable {
  final List<Movie> movies;
  final MovieStateStep step;

  const MovieState({
    required this.movies,
    required this.step,
  });

  MovieState copyWith({
    List<Movie>? movies,
    MovieStateStep? step,
  }) {
    return MovieState(
      movies: movies ?? this.movies,
      step: step ?? this.step,
    );
  }

  @override
  List<Object?> get props => [
        movies,
        step,
      ];
}
