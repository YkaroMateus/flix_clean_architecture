import '../../domain/entites/filter_movies.dart';

abstract class FilterMoviesDatasource {
  Future<FilterMovies> call();
}
