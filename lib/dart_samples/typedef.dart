import 'package:flutter_introduction/dart_samples/isolates.dart';

typedef MoviesRatingMap = Map<int, List<Movie>>;

void playWithTypedef() {
  final MoviesRatingMap map = {};
  map[5] = [
    Movie(title: "Glass Onion: Um mistério Knive's Out"),
    Movie(title: "Os Fabelmans"),
    Movie(title: "Aftersun"),
  ];
}
