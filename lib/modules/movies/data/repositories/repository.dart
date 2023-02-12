import 'package:flutter_introduction/modules/movies/domain/entity/movie.dart';
import 'package:flutter_introduction/modules/shared/core/result.dart';

class Repository {
  const Repository();

  Future<Result<List<Movie>>> getMovies() async {
    final movies = List.generate(15, (index) {
      return Movie(
        title: "Rocky Balboa $index",
      );
    });
    return Result.success(movies);
  }

  Result<Movie> getMovieChanged(Movie movie) {
    final newTitlePrefix = _getTitleChanged(movie.title);

    final index = movie.title.split(" ").last;

    final newMovie = movie.copyWith(
      title: "$newTitlePrefix $index",
    );
    return Result.success(newMovie);
  }

  String _getTitleChanged(String title) {
    if (title.contains("Creed")) {
      return "Rocky Balboa";
    }
    return "Creed";
  }
}
