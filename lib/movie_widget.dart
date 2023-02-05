import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_introduction/change_button_list.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_list.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({
    super.key,
    required this.bloc,
  });

  final MovieBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (context) => bloc,
      child: const Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              MovieList(),
              SliverToBoxAdapter(
                child: SizedBox(height: 8),
              ),
              ChangeButtonList(),
            ],
          ),
        ),
      ),
    );
  }
}
