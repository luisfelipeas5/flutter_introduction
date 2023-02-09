import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_introduction/app_toaster.dart';
import 'package:flutter_introduction/change_button_list.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_event.dart';
import 'package:flutter_introduction/movie_list.dart';
import 'package:flutter_introduction/movie_state.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({
    super.key,
  });

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  MovieBloc get bloc => BlocProvider.of<MovieBloc>(context);

  @override
  void initState() {
    super.initState();
    bloc.add(MovieLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieBloc, MovieState>(
      listener: _listener,
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

  void _listener(BuildContext context, MovieState state) {
    if (state.step == MovieStateStep.failed) {
      final appToaster = context.read<AppToaster>();
      appToaster.showFailureToast(state.failure!);
    }
  }
}
