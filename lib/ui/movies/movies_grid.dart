import 'package:flutter/material.dart';
import 'movie_grid_tile.dart';
import 'movies_manager.dart';
import '../../../models/movie.dart';
import 'package:provider/provider.dart';

class MoviesGrid extends StatelessWidget {
  const MoviesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final movies = context.select<MoviesManager, List<Movie>>(
        (moviesManager) => moviesManager.items);

    return SizedBox(
      height: height * 1 / 3,
      child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (ctx, i) => MovieGridTile(movies[i]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
      ),
    );
  }
}
