import 'package:flutter/foundation.dart';
import 'package:flutter_introduction/dart_samples/dart_samples.dart';

void main(List<String> args) {
  final nextMovie = getNextMovieInMonth(Month.february);
  if (kDebugMode) {
    print("nextMovie $nextMovie");
  }
}

Movie? getNextMovieInMonth(Month month) {
  switch (month) {
    case Month.january:
      return null;
    case Month.february:
      return Movie(
        title: "The Wale",
        director: "Darren Aronofsky",
        availableIn: [
          "movie theaters",
        ],
      );
  }
}

enum Month {
  january,
  february,
}
