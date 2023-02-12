import 'package:flutter_introduction/modules/movies/data/repositories/repository.dart';
import 'package:flutter_introduction/modules/movies/domain/entity/movie.dart';
import 'package:flutter_introduction/modules/shared/core/result.dart';

class ChangeMovie {
  final Repository _repository;

  ChangeMovie(this._repository);

  Result<Movie> call(Movie movie) => _repository.getMovieChanged(movie);
}
