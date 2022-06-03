import '../../../../domain/failures/movie_details_failure.dart';
import 'movie_details_states.dart';

class GetMovieDetailsFailureState implements MovieDetailsStates {
  final MovieDetailsFailure failure;

  GetMovieDetailsFailureState(this.failure);
}
