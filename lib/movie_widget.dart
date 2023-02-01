import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_event.dart';
import 'package:flutter_introduction/movie_state.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({
    super.key,
    required this.bloc,
  });

  final MovieBloc bloc;

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  ColorSwatch<int> _buttonColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTitle(),
          const SizedBox(height: 8),
          _buildChangeButton(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return BlocBuilder<MovieBloc, MovieState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return Center(
          child: Text(
            state.title,
          ),
        );
      },
    );
  }

  Widget _buildChangeButton() {
    return MaterialButton(
      onPressed: () {
        setState(() {
          _buttonColor = _genrateRandomColor();
        });
        widget.bloc.add(MovieChangeEvent());
      },
      color: _buttonColor,
      child: const Text("Trocar!"),
    );
  }

  MaterialAccentColor _genrateRandomColor() =>
      Colors.accents[Random().nextInt(Colors.accents.length)];
}
