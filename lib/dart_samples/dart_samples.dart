void runDartSamples() {
  // variablesDeclarations(true);
  // accessModifiers();
  // runIsolate();
  // playWithStreams();
  // playWithExtension();
}

abstract class Content {
  String getTitle();

  String getCreator();

  String getPresentation() => "${getTitle()} ${getCreator()}";
}

mixin LetterboxdContent on Content {
  int? get rating;
}

mixin JustWatchContent on Content {
  List<String> get availableIn;
}

class Movie extends Content with LetterboxdContent, JustWatchContent {
  final String title;
  final String director;
  @override
  final int? rating;
  @override
  final List<String> availableIn;

  Movie({
    required this.title,
    required this.director,
    this.rating,
    required this.availableIn,
  });

  @override
  String getCreator() => director;

  @override
  String getTitle() => title;
}

class TvShow extends Content with JustWatchContent {
  final String title;
  final String showRunner;
  @override
  final List<String> availableIn;

  TvShow({
    required this.title,
    required this.showRunner,
    required this.availableIn,
  });

  @override
  String getCreator() => showRunner;

  @override
  String getTitle() => title;
}
