import 'package:flutter_introduction/movie_controller.dart';
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
