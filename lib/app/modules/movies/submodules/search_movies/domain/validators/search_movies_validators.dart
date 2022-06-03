import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/entites/search.dart';

abstract class SearchMoviesValidators {
  bool hasSearch(Search parameters);
}

class SearchMoviesValidatorsImplementation implements SearchMoviesValidators {
  @override
  bool hasSearch(Search parameters) {
    // if (parameters.query.isNotEmpty) {
    //   return true;
    // } else {
    //   return false;
    // }

    return parameters.query.isNotEmpty;
  }
}
