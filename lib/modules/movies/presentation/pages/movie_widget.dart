import 'package:flutter/material.dart';
import 'package:flutter_introduction/feature_core/app_toaster.dart';
import 'package:flutter_introduction/modules/movies/presentation/controllers/movies/movie_controller.dart';
import 'package:flutter_introduction/modules/movies/presentation/controllers/movies/movie_controller_step.dart';
import 'package:flutter_introduction/modules/movies/presentation/widgets/change_button/change_button_list.dart';
import 'package:flutter_introduction/modules/movies/presentation/widgets/movie_title/movie_list.dart';
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

    ever(
      controller.step,
      condition: () {
        return controller.step.value == MovieControllerStep.failed;
      },
      _showToasterCallback,
    );
    controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildIndicator(),
              ),
              const MovieList(),
              const SliverToBoxAdapter(
                child: SizedBox(height: 8),
              ),
              const ChangeButtonList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return GetX<MovieController>(
      builder: (controller) {
        if (controller.step.value == MovieControllerStep.loading) {
          return Column(
            children: const [
              SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  void _showToasterCallback(MovieControllerStep step) {
    final appToaster = Get.find<AppToaster>();
    appToaster.showFailureToast(controller.failure.value!);
  }
}
