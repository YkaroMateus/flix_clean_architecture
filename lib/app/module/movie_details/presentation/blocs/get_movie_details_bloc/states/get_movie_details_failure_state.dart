import 'package:flix_clean_ark/app/module/movie_details/domain/failures/movie_details_failure.dart';

import 'get_movie_details_states.dart';

class GetMovieDetailsFailureState implements GetMovieDetailsStates {
  final MovieDetailsFailure failure;

  GetMovieDetailsFailureState(this.failure);
}
