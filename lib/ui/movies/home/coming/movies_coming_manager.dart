import 'package:movies/models/auth_token.dart';
import 'package:flutter/foundation.dart';
import 'package:movies/models/movie_comingsoon.dart';

import '../../../../services/movies_coming_service.dart';

class MoviesComingManager with ChangeNotifier {
  List<MovieComingSoon> _items = [];

  final MoviesComingService _moviesComingService;

  MoviesComingManager([AuthToken? authToken])
      : _moviesComingService = MoviesComingService(authToken);

  set authToken(AuthToken? authToken) {
    _moviesComingService.authToken = authToken;
  }

  Future<void> fetchMoviesComing([bool filterByUser = false]) async {
    _items = await _moviesComingService.fetchMoviesComing(filterByUser);
    notifyListeners();
  }

  Future<void> addMovieComing(MovieComingSoon movieComing) async {
    final newMovieComing =
        await _moviesComingService.addMovieComing(movieComing);
    if (newMovieComing != null) {
      _items.add(newMovieComing);
      notifyListeners();
    }
  }

  int get itemCount {
    return _items.length;
  }

  List<MovieComingSoon> get items {
    return [..._items];
  }

  // List<Movie> get nLastItems {
  //   return
  // }

  MovieComingSoon findById(String id) {
    return _items.firstWhere((movi) => movi.id == id);
  }

  Future<void> updateMovieComing(MovieComingSoon movieComing) async {
    final index = _items.indexWhere((item) => item.id == movieComing.id);
    if (index >= 0) {
      if (await _moviesComingService.updateMovieComing(movieComing)) {
        _items[index] = movieComing;
        notifyListeners();
      }
    }
  }

  Future<void> deleteMovieComing(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    MovieComingSoon? existingMovieComing = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _moviesComingService.deleteMovieComing(id)) {
      _items.insert(index, existingMovieComing);
      notifyListeners();
    }
  }
}
