import '../../../../domain/failures/search_movies_failure.dart';
import 'search_movies_states.dart';

class GetSearchMoviesFailureState implements SearchMoviesStates {
  final SearchMoviesFailure failure;

  GetSearchMoviesFailureState(this.failure);
}
