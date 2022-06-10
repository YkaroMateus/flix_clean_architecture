import 'package:flix_clean_ark/app/modules/movies/domain/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required int id,
    required String title,
    required String language,
    required String releaseDate,
    required String overview,
    required String poster,
    required String score,
  }) : super(
          id: id,
          title: title,
          language: language,
          releaseDate: releaseDate,
          overview: overview,
          poster: poster,
          score: score,
        );

  static MovieModel fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? -1,
      title: json['title'] ?? '',
      language: json["original_language"] ?? '',
      releaseDate: json["release_date"] ?? '',
      overview: json["overview"] ?? '',
      poster: json["poster_path"] ?? '',
      score: (json["vote_average"] ?? -1).toString(),
    );
  }
}
