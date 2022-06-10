import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/infrastructure/errors/search_movies_datasource_errors.dart';

class SearchMoviesDatasourceError implements SearchMoviesDatasourceErrors {
  final String message;

  SearchMoviesDatasourceError(this.message);
}
