import 'package:flutter/foundation.dart';
import 'package:flutter_introduction/dart_samples/dart_samples.dart';

void main(List<String> args) async {
  final mostWatchedMovie = await calculateMostWatchedMovie();
  if (kDebugMode) {
    print("Most watched movie ${mostWatchedMovie.title}");
  }
}

Future<Movie> calculateMostWatchedMovie() async {
  await Future.delayed(const Duration(seconds: 3));
  return Movie(
    title: "The Batman",
    director: "Matt Reeves",
    availableIn: ["HBO Max"],
  );
}
