import 'package:flix_clean_ark/app/module/most_popular_movies/infrastructure/errors/most_popular_movies_datasource_errors.dart';

class MostPopularMoviesDatasourceError extends MostPopularMoviesDatasourceErrors {
  final String message;

  MostPopularMoviesDatasourceError({required this.message});
}
