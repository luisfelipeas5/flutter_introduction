import 'package:flutter_introduction/modules/movies/domain/entity/movie.dart';
import 'package:flutter_introduction/modules/movies/data/repositories/repository.dart';
import 'package:flutter_introduction/modules/shared/core/result.dart';

class LoadMovies {
  final Repository _repository;

  LoadMovies(this._repository);

  Future<Result<List<Movie>>> call() => _repository.getMovies();
}
