import 'dart:math';

import 'package:flutter/foundation.dart';

void variablesDeclarations(bool isBrazil) {
  var draftMovieName = "The Fabelmans";
  if (isBrazil) {
    draftMovieName = "Um cinéfilo do barulho";
  }
  const director = "Steven Spielberg";

  final movieCrew = MovieCrew();
  final actorHighlighted = movieCrew.getHighlightActor();

  if (kDebugMode) {
    print(
      "Movie: $draftMovieName - "
      "Director: $director - "
      "Starring: $actorHighlighted - "
      "Actors: ${MovieCrew.actors}",
    );
  }
}

class MovieCrew {
  static const actors = [
    "Paul Dano",
    "Michelle Williams",
    "Gabriel LaBelle",
    "Julia Butters",
    "David Lynch",
    "Chloe East",
  ];

  String getHighlightActor() {
    final randomIndex = Random().nextInt(actors.length);
    return actors[randomIndex];
  }
}
