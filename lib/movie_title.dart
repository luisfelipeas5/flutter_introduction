import 'package:flutter/material.dart';
import 'package:flutter_introduction/movie.dart';
import 'package:get/get.dart';

class MovieTitle extends StatelessWidget {
  final Movie movie;

  const MovieTitle({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Center(
        child: Text(
          movie.title,
        ),
      ),
    );
  }

  void _onTap() => Get.toNamed('/movie-detail');
}
