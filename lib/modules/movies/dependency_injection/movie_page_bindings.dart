import 'package:flutter_introduction/modules/movies/presentation/controllers/movies/movie_controller.dart';
import 'package:get/get.dart';

class MoviePageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieController>(
      () => MovieController(
        Get.find(),
        Get.find(),
      ),
    );
  }
}
