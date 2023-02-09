import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/repository.dart';
import 'package:flutter_introduction/result.dart';

class ChangeMovie {
  final Repository _repository;

  ChangeMovie(this._repository);

  Result<Movie> call(Movie movie) => _repository.getMovieChanged(movie);
}
