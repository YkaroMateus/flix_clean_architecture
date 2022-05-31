import 'package:flix_clean_ark/app/module/most_popular_movies/domain/entites/most_popular_movies.dart';

class MostPopularMoviesModel extends MostPopularMovies {
  MostPopularMoviesModel({
    required int id,
    required String title,
    required String language,
    required String datadelancamento,
    required String overview,
    required String poster,
    required String score,
  }) : super(
          id: id,
          title: title,
          language: language,
          releaseDate: datadelancamento,
          overview: overview,
          poster: poster,
          score: score,
        );

  static MostPopularMoviesModel fromJson(Map<String, dynamic> json) {
    return MostPopularMoviesModel(
      id: json['id'] ?? -1,
      title: json['title'] ?? '',
      language: json["original_language"] ?? '',
      datadelancamento: json["release_date"] ?? '',
      overview: json["overview"] ?? '',
      poster: json["poster_path"] ?? '',
      score: (json["vote_average"] ?? -1).toString(),
    );
  }
}
