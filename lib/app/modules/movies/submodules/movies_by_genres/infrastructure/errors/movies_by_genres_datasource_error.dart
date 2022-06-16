import 'package:flix_clean_ark/app/modules/movies/submodules/movies_by_genres/infrastructure/errors/movies_by_genres_datasource_errors.dart';

class MoviesByGenresDatasourceError implements MoviesByGenresDatasourceErrors {
  final String message;

  MoviesByGenresDatasourceError(this.message);
}
