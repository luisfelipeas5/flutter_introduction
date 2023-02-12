import 'package:flutter/material.dart';
import 'package:flutter_introduction/feature_core/app_toaster.dart';
import 'package:flutter_introduction/modules/movies/domain/use_cases/load_movies.dart';
import 'package:flutter_introduction/modules/movies/domain/use_cases/change_movie.dart';
import 'package:flutter_introduction/modules/movies/presentation/pages/movie_detail_page.dart';
import 'package:flutter_introduction/modules/movies/presentation/pages/movie_widget.dart';
import 'package:flutter_introduction/modules/movies/data/repositories/repository.dart';
import 'package:flutter_introduction/modules/movies/dependency_injection/movie_page_bindings.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(const Repository());
  Get.lazyPut(
    () => ChangeMovie(
      Get.find(),
    ),
  );
  Get.lazyPut(
    () => LoadMovies(
      Get.find(),
    ),
  );
  Get.lazyPut<AppToaster>(
    () => const AppToaster(),
  );

  runApp(
    GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(name: '/', page: () => const MoviePage(), bindings: [
          MoviePageBindings(),
        ]),
        GetPage(
          name: '/movie-detail',
          page: () => const MovieDetailPage(),
        ),
      ],
    ),
  );
}
