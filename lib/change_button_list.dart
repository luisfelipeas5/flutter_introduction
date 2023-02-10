import 'package:flutter/material.dart';
import 'package:flutter_introduction/change_button.dart';
import 'package:flutter_introduction/movie_bloc.dart';
import 'package:get/get.dart';

class ChangeButtonList extends StatelessWidget {
  const ChangeButtonList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final state = Get.find<MovieController>().state;
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ChangeButton(
                movie: state.movies[index],
                index: index,
              );
            },
            childCount: state.movies.length,
          ),
        );
      },
    );
  }
}
