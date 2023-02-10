import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_introduction/app_toaster.dart';
import 'package:flutter_introduction/change_movie.dart';
import 'package:flutter_introduction/load_movies.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_detail_page.dart';
import 'package:flutter_introduction/movie_widget.dart';
import 'package:flutter_introduction/repository.dart';
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
        GetPage(
          name: '/',
          page: () => BlocProvider<MovieBloc>(
            create: (context) => MovieBloc(
              Get.find(),
              Get.find(),
            ),
            child: const MoviePage(),
          ),
        ),
        GetPage(
          name: '/movie-detail',
          page: () => const MovieDetailPage(),
        ),
      ],
    ),
  );
}
