class MovieComingSoon {
  final String? id;
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final String trailerUrl;
  final String cast;
  final String premiere;
  final String nation;
  final String director;

  MovieComingSoon({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.trailerUrl,
    required this.cast,
    required this.premiere,
    required this.nation,
    required this.director,
  });

  MovieComingSoon copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? imageUrl,
    String? trailerUrl,
    String? cast,
    String? premiere,
    String? nation,
    String? director,
  }) {
    return MovieComingSoon(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      trailerUrl: trailerUrl ?? this.trailerUrl,
      cast: cast ?? this.cast,
      premiere: premiere ?? this.premiere,
      nation: nation ?? this.nation,
      director: director ?? this.director,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'trailerUrl': trailerUrl,
      'cast': cast,
      'premiere': premiere,
      'nation': nation,
      'director': director,
    };
  }

  static MovieComingSoon fromJson(Map<String, dynamic> json) {
    return MovieComingSoon(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        category: json['category'],
        imageUrl: json['imageUrl'],
        trailerUrl: json['trailerUrl'],
        cast: json['cast'],
        premiere: json['premiere'],
        nation: json['nation'],
        director: json['director']);
  }
}
