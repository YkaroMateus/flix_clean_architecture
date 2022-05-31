import '../../../../domain/entites/movies_list.dart';
import 'most_popular_movies_states.dart';

class GetMoviesListSucessState implements MostPopularMoviesStates {
  final MoviesList movieList;

  GetMoviesListSucessState(this.movieList);
}
