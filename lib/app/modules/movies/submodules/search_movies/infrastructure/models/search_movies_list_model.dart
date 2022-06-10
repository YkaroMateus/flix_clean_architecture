import 'package:flix_clean_ark/app/modules/movies/domain/movie.dart';
import 'package:flix_clean_ark/app/modules/movies/infrastructure/models/movie_model.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_list.dart';

class SearchMoviesListModel extends SearchMoviesList {
  final List<Movie> movies;

  SearchMoviesListModel({required this.movies}) : super(movies: movies);
  static SearchMoviesListModel fromJson(Map<String, dynamic> json) {
    return SearchMoviesListModel(
      movies: ((json['results'] ?? []) as List).map((element) => MovieModel.fromJson(element)).toList(),
    );
  }
}
