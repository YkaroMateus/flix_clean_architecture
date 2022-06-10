import '../../../../domain/failures/most_popular_movies_failure.dart';
import 'most_popular_movies_states.dart';

class GetMostPopularMoviesFailureState implements MostPopularMoviesStates {
  final MostPopularMoviesFailure failure;

  GetMostPopularMoviesFailureState(this.failure);
}
