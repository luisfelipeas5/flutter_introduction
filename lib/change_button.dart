import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_event.dart';

class ChangeButton extends StatefulWidget {
  final Movie movie;
  final int index;

  const ChangeButton({
    super.key,
    required this.movie,
    required this.index,
  });

  @override
  State<ChangeButton> createState() => _ChangeButtonState();
}

class _ChangeButtonState extends State<ChangeButton> {
  ColorSwatch<int> _buttonColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        setState(() {
          _buttonColor = _genrateRandomColor();
        });

        final bloc = BlocProvider.of<MovieBloc>(context);
        bloc.add(MovieChangeEvent(
          index: widget.index,
        ));
      },
      color: _buttonColor,
      child: Text(
        "Trocar ${widget.movie.title}!",
      ),
    );
  }

  MaterialAccentColor _genrateRandomColor() =>
      Colors.accents[Random().nextInt(Colors.accents.length)];
}
