import 'package:flix_clean_ark/app/modules/most_popular_movies/domain/entites/movie.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/domain/entites/movies_list.dart';
import 'package:flix_clean_ark/app/modules/most_popular_movies/infrastructure/models/movie_model.dart';

class MoviesListModel extends MoviesList {
  final List<Movie> movies;
  MoviesListModel({required this.movies}) : super(movies: movies);

  static MoviesListModel fromJson(Map<String, dynamic> json) {
    return MoviesListModel(
      movies: ((json['results'] ?? []) as List)
          .map(
            (element) => MovieModel.fromJson(element),
          )
          .toList(),
    );
  }
}
