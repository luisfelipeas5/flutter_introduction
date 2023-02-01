import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_event.dart';
import 'package:flutter_introduction/movie_state.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({
    super.key,
  });

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final _movieBloc = MovieBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
        bloc: _movieBloc,
        builder: (context, state) {
          return Scaffold(
            body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    state.changed ? "Creed" : "Rocky Balboa",
                  ),
                ),
                const SizedBox(height: 8),
                MaterialButton(
                  onPressed: () {
                    _movieBloc.add(MovieChangeEvent());
                  },
                  color: Colors.blue,
                  child: const Text("Trocar!"),
                ),
              ],
            ),
          );
        });
  }
}
