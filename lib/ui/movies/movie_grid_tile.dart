// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/movie.dart';
import 'movie_detail_screen.dart';
import 'movies_manager.dart';

class MovieGridTile extends StatelessWidget {
  const MovieGridTile(
    this.movie, {
    super.key,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            MovieDetailScreen.routeName,
            arguments: movie.id,
          );
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 5.0,
                  offset: Offset(0, 1),
                  spreadRadius: 0.8,
                )
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
              footer: SizedBox(
                height: height * 1 / 15,
                child: buildGridFooterBar(context),
              ),
              child: GestureDetector(
                  child: Image.network(
                movie.imageUrl,
                fit: BoxFit.cover,
              )),
            ),
          ),
        ));
  }

  Widget buildGridFooterBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const [
            Color.fromARGB(175, 144, 10, 140),
            Color.fromARGB(175, 66, 18, 155),
          ],
        ),
      ),
      child: GridTileBar(
        //backgroundColor: Color.fromARGB(255, 232, 232, 232),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand'),
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: '${movie.imdb}',
                style: TextStyle(
                    color: Color.fromARGB(255, 229, 198, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              WidgetSpan(
                child: Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 229, 198, 0),
                ),
              )
            ])),
          ],
        ),
        trailing: ValueListenableBuilder<bool>(
          valueListenable: movie.isFavoriteListenable,
          builder: (ctx, isFavorite, child) {
            return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                ctx.read<MoviesManager>().toggleFavoriteStatus(movie);
              },
            );
          },
        ),
      ),
    );
  }
}
