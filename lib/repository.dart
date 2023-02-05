import 'package:flutter_introduction/movie.dart';

class Repository {
  Future<List<Movie>> getMovies() async {
    return List.generate(15, (index) {
      return Movie(
        title: "Rocky Balboa $index",
      );
    });
  }

  Movie getMovieChanged(Movie movie) {
    final newTitlePrefix = _getTitleChanged(movie.title);

    final index = movie.title.split(" ").last;

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
