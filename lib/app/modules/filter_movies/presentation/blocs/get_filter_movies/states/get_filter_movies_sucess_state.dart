import 'package:flix_clean_ark/app/modules/filter_movies/domain/entites/filter_movies.dart';
import 'package:flix_clean_ark/app/modules/filter_movies/presentation/blocs/get_filter_movies/states/filter_movies_states.dart';

class GetFilterMoviesSucessState implements FilterMoviesStates {
  final FilterMovies filterMovies;

  GetFilterMoviesSucessState(this.filterMovies);
}
