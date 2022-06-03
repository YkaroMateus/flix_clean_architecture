import '../../../../domain/entites/filter_movies.dart';
import 'filter_movies_states.dart';

class GetFilterMoviesSucessState implements FilterMoviesStates {
  final FilterMovies filterMovies;

  GetFilterMoviesSucessState(this.filterMovies);
}
