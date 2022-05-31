import 'package:flix_clean_ark/app/modules/movie_details/infrastructure/errors/movie_details_datasource_errors.dart';

class MovieDetailsDatasourceError implements MovieDetailsDatasourceErrors {
  final String message;

  MovieDetailsDatasourceError({required this.message});
}
