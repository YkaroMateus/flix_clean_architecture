import '../../../../domain/failures/movie_not_found_failure.dart';
import 'search_movies_states.dart';

class MovieNotFoundFailureState implements SearchMoviesStates {
  final MovieNotFoundFailure movieNotFoundFailure;

  MovieNotFoundFailureState(this.movieNotFoundFailure);
}
