import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/movie.dart';
import '../movie_grid_tile.dart';
import '../movies_manager.dart';

class MovieSuggestion extends StatelessWidget {
  const MovieSuggestion(this.director, {Key? key}) : super(key: key);
  final String director;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final movies = context.select<MoviesManager, List<Movie>>(
        (moviesManager) => moviesManager.items);

    final filter =
        movies.where((element) => element.director.contains(director)).toList();

    return SizedBox(
      height: height,
      child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        scrollDirection: Axis.vertical,
        itemCount: filter.length,
        itemBuilder: (ctx, i) => MovieGridTile(filter[i]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
      ),
    );
  }
}
