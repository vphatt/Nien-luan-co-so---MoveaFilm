import 'package:flutter/material.dart';
import 'package:movies/models/movie_comingsoon.dart';
import 'package:movies/ui/movies/user_movie_list_tile.dart';
import 'package:provider/provider.dart';

import '../../models/movie.dart';
import '../movies/home/coming/movies_coming_manager.dart';
import '../movies/home/coming/user_movie_coming_list_tile.dart';
import '../movies/movies_manager.dart';

class SearchForAdmin extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: Theme.of(context).appBarTheme.copyWith(toolbarHeight: 80),
      scaffoldBackgroundColor: const Color.fromARGB(255, 8, 6, 29),
      inputDecorationTheme: const InputDecorationTheme(
          filled: true, fillColor: Color.fromARGB(255, 53, 52, 75)),
      textTheme: const TextTheme(
        button: TextStyle(
          fontFamily: 'Quicksand',
          color: Colors.white,
          fontSize: 15,
        ),
        subtitle1: TextStyle(
          fontFamily: 'Quicksand',
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      hintColor: Colors.white,
    );
  }

  @override
  String get searchFieldLabel => 'Nhập tên phim';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_sharp),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final movies = context.select<MoviesManager, List<Movie>>(
        (moviesManager) => moviesManager.items);
    final suggestions = movies
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return UserMovieListTile(suggestions[index]);
        //
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final movies = context.select<MoviesManager, List<Movie>>(
        (moviesManager) => moviesManager.items);
    final suggestions = movies
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return UserMovieListTile(suggestions[index]);
        //
      },
    );
  }
}

//------------------------------------

class SearchForAdminComing extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: Theme.of(context).appBarTheme.copyWith(toolbarHeight: 80),
      scaffoldBackgroundColor: const Color.fromARGB(255, 8, 6, 29),
      inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Color.fromARGB(255, 53, 52, 75)),
      textTheme: const TextTheme(
        button: TextStyle(
          fontFamily: 'Quicksand',
          color: Colors.white,
          fontSize: 15,
        ),
        subtitle1: TextStyle(
          fontFamily: 'Quicksand',
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      hintColor: Colors.white,
    );
  }

  @override
  String get searchFieldLabel => 'Nhập tên phim';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_sharp),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final moviesComing =
        context.select<MoviesComingManager, List<MovieComingSoon>>(
            (moviesComingManager) => moviesComingManager.items);
    final suggestions = moviesComing
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return UserMovieComingListTile(suggestions[index]);
        //
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final moviesComing =
        context.select<MoviesComingManager, List<MovieComingSoon>>(
            (moviesComingManager) => moviesComingManager.items);
    final suggestions = moviesComing
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return UserMovieComingListTile(suggestions[index]);
        //
      },
    );
  }
}
