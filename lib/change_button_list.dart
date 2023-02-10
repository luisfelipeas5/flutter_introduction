import 'package:flutter/material.dart';
import 'package:flutter_introduction/change_button.dart';
import 'package:flutter_introduction/movie_controller.dart';
import 'package:get/get.dart';

class ChangeButtonList extends StatelessWidget {
  const ChangeButtonList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetX<MovieController>(
      builder: (controller) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ChangeButton(
                movie: controller.movies[index],
                index: index,
              );
            },
            childCount: controller.movies.length,
          ),
        );
      },
    );
  }
}
