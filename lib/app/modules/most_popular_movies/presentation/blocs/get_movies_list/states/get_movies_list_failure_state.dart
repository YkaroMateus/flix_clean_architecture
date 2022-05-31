import 'package:flix_clean_ark/app/modules/most_popular_movies/domain/failures/movies_list_failure.dart';
import 'most_popular_movies_states.dart';

class GetMoviesListFailureState implements MostPopularMoviesStates {
  final MoviesListFailure failure;

  GetMoviesListFailureState(this.failure);
}
