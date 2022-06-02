import 'package:flix_clean_ark/app/modules/filter_movies/domain/entites/filter_movies.dart';

abstract class FilterMoviesDatasource {
  Future<FilterMovies> call();
}
