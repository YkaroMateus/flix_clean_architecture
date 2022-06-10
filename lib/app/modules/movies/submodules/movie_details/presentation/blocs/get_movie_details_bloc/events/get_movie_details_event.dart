import 'package:flix_clean_ark/app/modules/movies/submodules/movie_details/domain/entites/movie_details_parameters.dart';

import 'movie_details_events.dart';

class GetMovieDetailsEvent implements MovieDetailsEvents {
  final MovieDetailsParameters parameters;

  const GetMovieDetailsEvent(this.parameters);
}
