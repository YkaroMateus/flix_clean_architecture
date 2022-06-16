import '../../../../domain/movies_list.dart';
import '../../domain/entites/search_movies_parameters.dart';

abstract class SearchMoviesDatasource {
  Future<MoviesList> call(SearchMoviesParameters parameters);
}
