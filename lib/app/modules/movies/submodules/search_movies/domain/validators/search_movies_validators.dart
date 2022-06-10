import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search_movies_parameters.dart';

abstract class SearchMoviesValidators {
  bool hasSearch(SearchMoviesParameters parameters);
}

class SearchMoviesValidatorsImplementation implements SearchMoviesValidators {
  @override
  bool hasSearch(SearchMoviesParameters parameters) {
    return parameters.query.isNotEmpty;
  }
}
