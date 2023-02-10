import 'package:flutter/material.dart';
import 'package:flutter_introduction/movie.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:flutter_introduction/movie_title.dart';
import 'package:get/get.dart';

class MovieList extends StatelessWidget {
  const MovieList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final state = Get.find<MovieController>().state;
        return _buildList(state.movies);
      },
    );
  }

  Widget _buildList(List<Movie> movies) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final movie = movies[index];
          return _buildMovie(movie);
        },
        childCount: movies.length,
      ),
    );
  }

  Widget _buildMovie(Movie movie) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MovieTitle(
        movie: movie,
      ),
    );
  }
}
