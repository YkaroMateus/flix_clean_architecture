import 'package:flix_clean_ark/app/modules/most_popular_movies/domain/failures/movies_list_failures.dart';

class MoviesListFailure implements MoviesListFailures {
  final String message;

  MoviesListFailure({required this.message});
}
