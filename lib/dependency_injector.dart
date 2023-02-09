import 'package:flutter/material.dart';
import 'package:flutter_introduction/app_toaster.dart';
import 'package:flutter_introduction/change_movie.dart';
import 'package:flutter_introduction/load_movies.dart';
import 'package:flutter_introduction/repository.dart';
import 'package:provider/provider.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => const Repository()),
        Provider(
          create: (context) => ChangeMovie(
            context.read(),
          ),
        ),
        Provider(
          create: (context) => LoadMovies(
            context.read(),
          ),
        ),
        Provider(create: (context) => const AppToaster()),
      ],
      child: child,
    );
  }
}
