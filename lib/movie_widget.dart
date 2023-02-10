import 'package:flutter/material.dart';
import 'package:flutter_introduction/app_toaster.dart';
import 'package:flutter_introduction/change_button_list.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_list.dart';
import 'package:flutter_introduction/movie_state.dart';
import 'package:get/get.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({
    super.key,
  });

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  MovieController get controller => Get.find<MovieController>();

  @override
  void initState() {
    super.initState();
    controller.load();
    ever(
      controller.stateObs,
      _listener,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
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

  void _listener(MovieState state) {
    if (state.step == MovieStateStep.failed) {
      final appToaster = Get.find<AppToaster>();
      appToaster.showFailureToast(state.failure!);
    }
  }
}
