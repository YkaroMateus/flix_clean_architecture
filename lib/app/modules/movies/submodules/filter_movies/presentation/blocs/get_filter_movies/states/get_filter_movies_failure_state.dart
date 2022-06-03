import '../../../../domain/failures/filter_movies_failure.dart';
import 'filter_movies_states.dart';

class GetFilterMoviesFailureState implements FilterMoviesStates {
  final FilterMoviesFailure filterMoviesFailure;

  GetFilterMoviesFailureState(this.filterMoviesFailure);
}
