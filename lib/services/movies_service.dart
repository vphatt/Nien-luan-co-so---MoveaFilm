// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/auth_token.dart';
import './firebase_service.dart';

class MoviesService extends FirebaseService {
  MoviesService([AuthToken? authToken]) : super(authToken);
  Future<List<Movie>> fetchMovies([bool filterByUser = false]) async {
    final List<Movie> movies = [];

    try {
      final filters =
          filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      final moviesUrl =
          Uri.parse('$databaseUrl/movies.json?auth=$token&$filters');
      final response = await http.get(moviesUrl);
      final moviesMap = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print(moviesMap['error']);
        return movies;
      }

      final userFavoritesUrl =
          Uri.parse('$databaseUrl/userFavorites/$userId.json?auth=$token');
      final userFavoritesResponse = await http.get(userFavoritesUrl);
      final userFavoritesMap = json.decode(userFavoritesResponse.body);

      moviesMap.forEach((movieId, movie) {
        final isFavorite = (userFavoritesMap == null)
            ? false
            : (userFavoritesMap[movieId] ?? false);

        movies.add(
          Movie.fromJson({
            'id': movieId,
            ...movie,
          }).copyWith(isFavorite: isFavorite),
        );
      });
      return movies;
    } catch (error) {
      print(error);
      return movies;
    }
  }

  Future<Movie?> addMovie(Movie movie) async {
    try {
      final url = Uri.parse('$databaseUrl/movies.json?auth=$token');
      final response = await http.post(
        url,
        body: json.encode(
          movie.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return movie.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updateMovie(Movie movie) async {
    try {
      final url = Uri.parse('$databaseUrl/movies/${movie.id}.json?auth=$token');
      final response = await http.patch(
        url,
        body: json.encode(movie.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteMovie(String id) async {
    try {
      final url = Uri.parse('$databaseUrl/movies/$id.json?auth=$token');
      final response = await http.delete(url);

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> saveFavoriteStatus(Movie movie) async {
    try {
      final url = Uri.parse(
          '$databaseUrl/userFavorites/$userId/${movie.id}.json?auth=$token');
      final response = await http.put(
        url,
        body: json.encode(
          movie.isFavorite,
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
