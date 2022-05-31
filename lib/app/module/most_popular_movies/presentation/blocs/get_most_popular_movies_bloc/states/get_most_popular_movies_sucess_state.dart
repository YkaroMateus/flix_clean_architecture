import 'package:flix_clean_ark/app/module/most_popular_movies/domain/entites/most_popular_movies.dart';
import 'package:flix_clean_ark/app/module/most_popular_movies/presentation/blocs/get_most_popular_movies_bloc/states/get_most_popular_movies_states.dart';

class GetMostPopularMoviesSucessState implements GetMostPopularMoviesStates {
  final MostPopularMovies entity;

  GetMostPopularMoviesSucessState(this.entity);
}
