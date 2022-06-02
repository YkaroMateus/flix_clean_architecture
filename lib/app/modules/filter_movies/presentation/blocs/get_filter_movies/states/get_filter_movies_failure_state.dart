import 'package:flix_clean_ark/app/modules/filter_movies/domain/failures/filter_movies_failure.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/presentation/blocs/get_filter_movies/states/filter_movies_states.dart';

class GetFilterMoviesFailureState implements FilterMoviesStates {
  final FilterMoviesFailure filterMoviesFailure;

  GetFilterMoviesFailureState(this.filterMoviesFailure);
}
