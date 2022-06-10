import '../../../../domain/entites/movies_list.dart';
import 'most_popular_movies_states.dart';

class GetMostPopularMoviesSucessState implements MostPopularMoviesStates {
  final MoviesList movieList;

  GetMostPopularMoviesSucessState(this.movieList);
}
