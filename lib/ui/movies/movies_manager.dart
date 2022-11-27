import 'package:movies/models/auth_token.dart';
import 'package:flutter/foundation.dart';
import '../../models/movie.dart';
import '../../services/movies_service.dart';

class MoviesManager with ChangeNotifier {
  List<Movie> _items = [];

  final MoviesService _moviesService;

  MoviesManager([AuthToken? authToken])
      : _moviesService = MoviesService(authToken);

  set authToken(AuthToken? authToken) {
    _moviesService.authToken = authToken;
  }

  Future<void> fetchMovies([bool filterByUser = false]) async {
    _items = await _moviesService.fetchMovies(filterByUser);
    notifyListeners();
  }

  Future<void> addMovie(Movie movie) async {
    final newMovie = await _moviesService.addMovie(movie);
    if (newMovie != null) {
      _items.add(newMovie);
      notifyListeners();
    }
  }

  int get itemCount {
    return _items.length;
  }

  List<Movie> get items {
    return [..._items];
  }

  List<Movie> get favoriteItems {
    return _items.where((movieItem) => movieItem.isFavorite).toList();
  }

  // List<Movie> get nLastItems {
  //   return
  // }

  Movie findById(String id) {
    return _items.firstWhere((movi) => movi.id == id);
  }

  Future<void> updateMovie(Movie movie) async {
    final index = _items.indexWhere((item) => item.id == movie.id);
    if (index >= 0) {
      if (await _moviesService.updateMovie(movie)) {
        _items[index] = movie;
        notifyListeners();
      }
    }
  }

  Future<void> deleteMovie(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Movie? existingMovie = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _moviesService.deleteMovie(id)) {
      _items.insert(index, existingMovie);
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Movie movie) async {
    final savedStatus = movie.isFavorite;
    movie.isFavorite = !savedStatus;

    if (!await _moviesService.saveFavoriteStatus(movie)) {
      movie.isFavorite = savedStatus;
    }
  }
}
