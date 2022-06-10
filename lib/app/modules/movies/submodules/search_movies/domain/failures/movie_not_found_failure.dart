import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/failures/search_movies_failures.dart';

class MovieNotFoundFailure implements SearchMoviesFailures {
  final String message;

  MovieNotFoundFailure(this.message);
}
