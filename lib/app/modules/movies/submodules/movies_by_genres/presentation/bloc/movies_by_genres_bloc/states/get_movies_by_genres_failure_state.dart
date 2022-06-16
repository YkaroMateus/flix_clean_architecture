import '../../../../domain/failures/movies_by_genres_failure.dart';
import 'movies_by_genres_states.dart';

class GetMoviesByGenresFailureState implements MoviesByGenresStates {
  final MoviesByGenresFailure failure;

  GetMoviesByGenresFailureState(this.failure);
}
