import 'package:flutter/material.dart';
import 'package:flutter_introduction/movie.dart';

class MovieTitle extends StatelessWidget {
  final Movie movie;

  const MovieTitle({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        movie.title,
      ),
    );
  }
}
