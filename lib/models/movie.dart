import 'package:flutter/foundation.dart';

class Movie {
  final String? id;
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final String videoUrl;
  final double imdb;
  final String duration;
  final String cast;
  final int year;
  final String nation;
  final String director;
  final ValueNotifier<bool> _watch;
  final ValueNotifier<bool> _isFavorite;

  Movie({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.videoUrl,
    required this.imdb,
    required this.duration,
    required this.cast,
    required this.year,
    required this.nation,
    required this.director,
    watch = false,
    isFavorite = false,
  })  : _watch = ValueNotifier(watch),
        _isFavorite = ValueNotifier(isFavorite);

  //Lấy giá trị mới cho isFavorite
  set isFavorite(bool newValue) {
    _isFavorite.value = newValue;
  }

  bool get isFavorite {
    return _isFavorite.value;
  }

  ValueNotifier<bool> get isFavoriteListenable {
    return _isFavorite;
  }

  //lấy giá trị mới cho view
  set watch(bool newValue) {
    _watch.value = newValue;
  }

  bool get watch {
    return _watch.value;
  }

  ValueNotifier<bool> get watchedListenable {
    return _watch;
  }

  Movie copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? imageUrl,
    String? videoUrl,
    double? imdb,
    String? duration,
    String? cast,
    int? year,
    bool? watch,
    String? nation,
    String? director,
    bool? isFavorite,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      imdb: imdb ?? this.imdb,
      duration: duration ?? this.duration,
      cast: cast ?? this.cast,
      year: year ?? this.year,
      watch: watch ?? this.watch,
      nation: nation ?? this.nation,
      director: director ?? this.director,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'imdb': imdb,
      'duration': duration,
      'cast': cast,
      'year': year,
      'nation': nation,
      'director': director,
    };
  }

  static Movie fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        category: json['category'],
        imageUrl: json['imageUrl'],
        videoUrl: json['videoUrl'],
        imdb: json['imdb'],
        duration: json['duration'],
        cast: json['cast'],
        year: json['year'],
        nation: json['nation'],
        director: json['director']);
  }
}
