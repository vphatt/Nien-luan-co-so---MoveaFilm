import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../movies_manager.dart';
import '../../../../models/movie.dart';
import 'package:provider/provider.dart';

import 'movie_carousel_slide.dart';

class MovieCarousel extends StatelessWidget {
  final int length;

  const MovieCarousel(this.length, {super.key});

  @override
  Widget build(BuildContext context) {
    final movies = context.select<MoviesManager, List<Movie>>(
        (moviesManager) => moviesManager.items);

    final filter = movies.reversed.toList();

    return SizedBox(
      child: CarouselSlider.builder(
        itemCount: length,
        itemBuilder: (context, index, realIndex) =>
            MovieCarouselSlide(filter[index]),
        options: CarouselOptions(
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 700),
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}
