import 'package:flix_clean_ark/app/module/movie_details/domain/entites/movie_details.dart';
import 'package:flix_clean_ark/app/module/movie_details/presenter/blocs/get_movie_details_bloc/states/get_movie_details_states.dart';

class GetMovieDetailsSucessState implements GetMovieDetailsStates {
  final MovieDetails entity;

  GetMovieDetailsSucessState(this.entity);
}
