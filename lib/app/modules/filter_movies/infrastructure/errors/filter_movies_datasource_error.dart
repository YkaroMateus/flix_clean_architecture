import 'package:flix_clean_ark/app/modules/filter_movies/infrastructure/errors/filter_movies_datasource_errors.dart';

class FilterMoviesDatasourceError implements FilterMoviesDatasourceErrors {
  final String message;

  FilterMoviesDatasourceError({required this.message});
}
