import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_detail_page.dart';
import 'package:flutter_introduction/movie_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_introduction/app_toaster.dart';
import 'package:flutter_introduction/change_movie.dart';
import 'package:flutter_introduction/load_movies.dart';
import 'package:flutter_introduction/repository.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => const Repository()),
        Bind(
          (i) => ChangeMovie(
            i(),
          ),
        ),
        Bind(
          (i) => LoadMovies(
            i(),
          ),
        ),
        Bind<AppToaster>(
          (i) => const AppToaster(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => BlocProvider<MovieBloc>(
            create: (context) => MovieBloc(
              context.read(),
              context.read(),
            ),
            child: const MoviePage(),
          ),
        ),
        ChildRoute(
          '/movie-detail',
          child: (context, args) => const MovieDetailPage(),
        ),
      ];
}
