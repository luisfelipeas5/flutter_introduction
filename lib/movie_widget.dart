import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_introduction/change_button.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_list.dart';

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
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (context) => widget.bloc,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: const [
              Expanded(
                child: MovieList(),
              ),
              SizedBox(height: 8),
              ChangeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
