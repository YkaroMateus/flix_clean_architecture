import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_list.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_parameters.dart';

abstract class SearchMoviesDatasource {
  Future<SearchMoviesList> call(SearchMoviesParameters parameters);
}
