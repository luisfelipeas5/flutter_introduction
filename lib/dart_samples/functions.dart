import 'package:flutter_introduction/dart_samples/isolates.dart';

void playWithFunctions() {
  final userMovies = getMoviesOf("test@user");
  final myMovies = getMyMovies(prefixFilter: "A");
  final yearMovies = getMoviesYear(year: 2022);
}

List<Movie> getMoviesOf(String username) {
  return [
    Movie(title: "X: A Marca da Morte"),
  ];
}

List<Movie> getMyMovies({
  String? prefixFilter,
}) {
  return [
    Movie(title: "Castelo Animado"),
  ];
}

List<Movie> getMoviesYear({
  required int year,
}) {
  return [
    Movie(title: "Pinnochio de Guillhermo del Toro"),
  ];
}
