import 'dart:isolate';

void runIsolate() async {
  final movie = Movie(
    title: "Decisão de Partir",
    rating: 4.5,
  );
  final newMovie = await Isolate.run(() async {
    return await _editMovie(movie);
  });
  print('Old movie\'s rating: ${movie.rating}');
  //print: flutter: Old movie's rating: 4.5

  print('New movie\'s rating: ${newMovie.rating}');
  //print:flutter: New movie's rating: 5.0
}

Future<Movie> _editMovie(Movie movie) async {
  movie.rating = 5;
  return movie;
}

class Movie {
  final String title;
  double? rating;

  Movie({
    required this.title,
    this.rating,
  });
}
