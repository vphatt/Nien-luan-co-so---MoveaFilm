import 'package:flutter/material.dart';
import 'package:movies/models/movie_comingsoon.dart';
import 'package:provider/provider.dart';

import 'coming_grid_tile.dart';
import 'movies_coming_manager.dart';

class ComingGrid extends StatelessWidget {
  const ComingGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final moviesComing =
        context.select<MoviesComingManager, List<MovieComingSoon>>(
            (moviesComingManager) => moviesComingManager.items);

    return SizedBox(
      height: height * 1 / 3,
      child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (ctx, i) => ComingGridTile(moviesComing[i]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
      ),
    );
  }
}
