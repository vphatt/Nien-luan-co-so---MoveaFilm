import 'package:flutter/material.dart';
import '../../../../../models/movie.dart';
import 'package:provider/provider.dart';

import 'movie_detail_screen.dart';
import 'movies_manager.dart';

class MoviesFavoriteList extends StatelessWidget {
  const MoviesFavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final movies = context.select<MoviesManager, List<Movie>>(
        (moviesManager) => moviesManager.favoriteItems);

    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 8, 6, 29),
            Color.fromARGB(217, 35, 27, 110),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  MovieDetailScreen.routeName,
                  arguments: movies[index].id,
                );
              },
              child: Container(
                height: height * 1 / 8,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 14, 46, 99),
                    Color.fromARGB(217, 101, 26, 105),
                  ],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                )),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        child: Image.network(
                          movies[index].imageUrl,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            movies[index].title,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        )),
                    Expanded(
                      flex: 1,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: movies[index].isFavoriteListenable,
                        builder: (ctx, isFavorite, child) {
                          return IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                            ),
                            color: Theme.of(context).colorScheme.secondary,
                            onPressed: () {
                              ctx
                                  .read<MoviesManager>()
                                  .toggleFavoriteStatus(movies[index]);
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
