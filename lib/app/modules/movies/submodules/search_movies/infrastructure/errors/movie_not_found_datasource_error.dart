import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/infrastructure/errors/search_movies_datasource_errors.dart';

class MovieNotFoundDatasourceError implements SearchMoviesDatasourceErrors {
  final String message;

  MovieNotFoundDatasourceError({required this.message});
}
