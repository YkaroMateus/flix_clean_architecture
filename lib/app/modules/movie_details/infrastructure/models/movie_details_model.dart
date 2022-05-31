import 'package:flix_clean_ark/app/modules/movie_details/infrastructure/models/movie_details_genres_model.dart';
import '../../domain/entites/movie_details.dart';
import '../../domain/entites/movie_details_genres.dart';

class MovieDetailsModel extends MovieDetails {
  MovieDetailsModel({
    required int id,
    required String title,
    required String language,
    required String datadelancamento,
    required String overview,
    required String poster,
    required String score,
    required int duracao,
    required List<MovieDetailsGenres> generos,
    required String sitemovie,
  }) : super(
          id: id,
          title: title,
          language: language,
          releaseDate: datadelancamento,
          overview: overview,
          poster: poster,
          score: score,
          runtime: duracao,
          genres: generos,
          site: sitemovie,
        );

  static MovieDetailsModel fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
        id: json['id'] ?? -1,
        title: json['title'] ?? '',
        language: json['original_language'] ?? '',
        datadelancamento: json['release_date'] ?? '',
        overview: json['overview'] ?? '',
        poster: json['poster_path'] ?? '',
        score: (json['vote_average'] ?? -1).toString(),
        duracao: json['runtime'] ?? -1,
        generos: ((json['genres'] ?? []) as List)
            .map((element) => MovieDetailsGenresModel.fromJson(element))
            .toList(),
        sitemovie: json['homepage']);
  }
}
