import 'package:flix_clean_ark/app/modules/most_popular_movies/infrastructure/errors/movies_list_datasource_errors.dart';

class MoviesListDatasourceError implements MoviesListDatasourceErrors {
  final String message;

  MoviesListDatasourceError({required this.message});
}
