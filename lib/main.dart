import 'package:flutter/material.dart';
import 'package:flutter_introduction/app_toaster.dart';
import 'package:flutter_introduction/change_movie.dart';
import 'package:flutter_introduction/load_movies.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_widget.dart';
import 'package:flutter_introduction/repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _repository = const Repository();
  LoadMovies get _loadMovies => LoadMovies(_repository);
  ChangeMovie get _changeMovie => ChangeMovie(_repository);

  final _appToaster = AppToaster();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MoviePage(
        appToaster: _appToaster,
        bloc: MovieBloc(
          _loadMovies,
          _changeMovie,
        ),
      ),
    );
  }
}
