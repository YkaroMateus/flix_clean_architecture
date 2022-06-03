import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/failures/search_movies_failures.dart';

class EmptySearchFailure implements SearchMoviesFailures {
  final String message;

  EmptySearchFailure(this.message);
}
