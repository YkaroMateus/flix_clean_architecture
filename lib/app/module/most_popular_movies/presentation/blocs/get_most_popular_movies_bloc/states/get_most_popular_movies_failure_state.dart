import 'package:flix_clean_ark/app/module/most_popular_movies/domain/failures/most_popular_movies_failure.dart';

import 'get_most_popular_movies_states.dart';

class GetMostPopularMoviesFailureState implements GetMostPopularMoviesStates {
  final MostPopularMoviesFailure failure;

  GetMostPopularMoviesFailureState(this.failure);
}
