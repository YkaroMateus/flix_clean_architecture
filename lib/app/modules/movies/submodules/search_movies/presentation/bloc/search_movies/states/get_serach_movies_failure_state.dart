import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/domain/failures/search_movies_failure.dart';
import 'package:flix_clean_ark/app/modules/movies/submodules/search_movies/presentation/bloc/search_movies/states/search_movies_states.dart';

class GetSearchMoviesFailureState implements SearchMoviesStates {
  final SearchMoviesFailure failure;

  GetSearchMoviesFailureState(this.failure);
}
