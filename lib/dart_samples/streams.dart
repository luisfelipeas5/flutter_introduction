import 'dart:async';

void playWithStreams() {
  _getMovieStreams().listen((event) {
    print("Movie $event");
  });
}

Stream<String> _getMovieStreams() {
  final streamController = StreamController<String>.broadcast();
  streamController.onListen = () {
    _generateStreamData(streamController);
  };
  return streamController.stream;
}

void _generateStreamData(StreamController<String> streamController) async {
  streamController.add("O Batman");
  await Future.delayed(const Duration(seconds: 1));
  streamController.add("Top Gun Maverick");
  await Future.delayed(const Duration(seconds: 2));
  streamController.add("Avatar: A Forma da Água");
  await Future.delayed(const Duration(seconds: 1));
  streamController.add("Batem à Porta");
}
