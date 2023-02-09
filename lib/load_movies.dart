import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/repository.dart';
import 'package:flutter_introduction/result.dart';

class LoadMovies {
  final Repository _repository;

  LoadMovies(this._repository);

  Future<Result<List<Movie>>> call() => _repository.getMovies();
}
