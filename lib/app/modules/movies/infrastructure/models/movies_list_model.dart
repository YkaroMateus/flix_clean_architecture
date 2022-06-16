import 'package:flix_clean_ark/app/modules/movies/infrastructure/models/movie_model.dart';
import '../../domain/movie.dart';
import '../../domain/movies_list.dart';

class MoviesListModel extends MoviesList {
  final List<Movie> movies;

  MoviesListModel({required this.movies}) : super(movies: movies);

  static MoviesListModel fromJson(Map<String, dynamic> json) {
    return MoviesListModel(
      movies: ((json['results'] ?? []) as List).map((element) => MovieModel.fromJson(element)).toList(),
    );
  }
}
