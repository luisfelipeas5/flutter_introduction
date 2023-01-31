import 'package:flutter/material.dart';
import 'package:flutter_introduction/dart_samples/dart_samples.dart';
import 'package:flutter_introduction/movie_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runDartSamples();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MoviePage(),
    );
  }
}
