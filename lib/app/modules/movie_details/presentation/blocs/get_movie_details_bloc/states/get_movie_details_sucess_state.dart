import 'package:flix_clean_ark/app/modules/movie_details/domain/entites/movie_details.dart';
import 'movie_details_states.dart';

class GetMovieDetailsSucessState implements MovieDetailsStates {
  final MovieDetails entity;

  GetMovieDetailsSucessState(this.entity);
}
