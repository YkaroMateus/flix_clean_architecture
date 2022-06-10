import '../../../../domain/entites/movie_details.dart';
import 'movie_details_states.dart';

class GetMovieDetailsSucessState implements MovieDetailsStates {
  final MovieDetails movieDetails;

  GetMovieDetailsSucessState(this.movieDetails);
}
