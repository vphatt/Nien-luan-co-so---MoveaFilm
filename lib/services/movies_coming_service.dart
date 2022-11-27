// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_token.dart';
import '../models/movie_comingsoon.dart';
import './firebase_service.dart';

class MoviesComingService extends FirebaseService {
  MoviesComingService([AuthToken? authToken]) : super(authToken);
  Future<List<MovieComingSoon>> fetchMoviesComing(
      [bool filterByUser = false]) async {
    final List<MovieComingSoon> moviesComing = [];

    try {
      final filters =
          filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      final moviesComingUrl =
          Uri.parse('$databaseUrl/moviesComing.json?auth=$token&$filters');
      final response = await http.get(moviesComingUrl);
      final moviesComingMap =
          json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print(moviesComingMap['error']);
        return moviesComing;
      }

      moviesComingMap.forEach((movieComingId, movieComing) {
        moviesComing.add(MovieComingSoon.fromJson({
          'id': movieComingId,
          ...movieComing,
        }));
      });
      return moviesComing;
    } catch (error) {
      print(error);
      return moviesComing;
    }
  }

  Future<MovieComingSoon?> addMovieComing(MovieComingSoon movieComing) async {
    try {
      final url = Uri.parse('$databaseUrl/moviesComing.json?auth=$token');
      final response = await http.post(
        url,
        body: json.encode(
          movieComing.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return movieComing.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updateMovieComing(MovieComingSoon movieComing) async {
    try {
      final url = Uri.parse(
          '$databaseUrl/moviesComing/${movieComing.id}.json?auth=$token');
      final response = await http.patch(
        url,
        body: json.encode(movieComing.toJson()),
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

  Future<bool> deleteMovieComing(String id) async {
    try {
      final url = Uri.parse('$databaseUrl/moviesComing/$id.json?auth=$token');
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
}
