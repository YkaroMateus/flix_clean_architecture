import 'package:flix_clean_ark/app/modules/movie_details/domain/entites/movie_details_genres.dart';

class MovieDetails {
  final int id;
  final String title;
  final String language;
  final String releaseDate;
  final String overview;
  final String poster;
  final String score;
  final int runtime;
  final List<MovieDetailsGenres> genres;
  final String site;

  MovieDetails({
    required this.id,
    required this.title,
    required this.language,
    required this.releaseDate,
    required this.overview,
    required this.poster,
    required this.score,
    required this.runtime,
    required this.genres,
    required this.site,
  });
}
