import '../../../../../../domain/movies_list.dart';
import 'search_movies_states.dart';

class GetSearchMoviesSucessState implements SearchMoviesStates {
  final MoviesList searchMoviesList;

  GetSearchMoviesSucessState(this.searchMoviesList);
}
